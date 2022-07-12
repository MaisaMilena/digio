import Foundation

// MARK: API auxiliars
public enum HTTPMethod: String {
    case get = "GET"
}

public enum APIError: Error {
    case urlNotFound
    case decode
    case internetConection
    
    var description: String {
        switch self {
        case .urlNotFound:
            return Strings.ApiError.urlNotFound
        case .decode:
            return Strings.ApiError.decode
        case .internetConection:
            return Strings.ApiError.internetConection
        }
    }
}

// MARK: API
class Api<T: Decodable> {
    private let endpoint: ApiEndpoint
    private var debugEndpoint: ApiEndpoint?
    
    init(endpoint: ApiEndpoint) {
        self.endpoint = endpoint
    }

    public func execute(completion: @escaping (Result<T, APIError>) -> Void) {
        handleDebug { result in
            switch result {
            case .failure:
                self.handleURL { result in
                    completion(result)
                }
            case let .success(data):
                completion(.success(data))
            }
        }
    }
    
    public func setDebugEndpoint(_ endpoint: ApiEndpoint) {
        debugEndpoint = endpoint
    }
    
    // MARK: Handle auxiliars
    private func handleURL(completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = endpoint.getURL() else {
            completion(.failure(.urlNotFound))
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            completion(self?.handleSession(data, response, error) ?? .failure(.urlNotFound))
        }
        .resume()
    }
    
    private func handleDebug(completion: @escaping (Result<T, APIError>) -> Void) {
        if let debugEndpoint = debugEndpoint {
            guard let url = debugEndpoint.getURL() else {
                completion(.failure(.urlNotFound))
                return
            }
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                completion(self?.handleSession(data, response, error) ?? .failure(.urlNotFound))
            }
            .resume()
        } else {
            completion(.failure(.urlNotFound))
        }
    }
    
    // MARK: Handle session and data
    private func handleSession(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<T, APIError> {
        if error != nil {
            return .failure(.internetConection)
        }

        guard self.handleResponse(response: response) != nil else {
            return .failure(.urlNotFound)
        }

        guard let model = self.handleJSONParse(data: data) else {
            return .failure(.decode)
        }

        return .success(model)
    }
    
    private func handleJSONParse(data: Data?) -> T? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    // swiftlint:disable indentation_width
    private func handleResponse(response: URLResponse?) -> HTTPURLResponse? {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            return nil
        }
        return httpResponse
    }
}
