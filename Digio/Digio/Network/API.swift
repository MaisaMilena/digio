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

    func execute(completion: @escaping (Result<T, APIError>) -> Void) {
        if let debugResult = handleDebug() {
            completion(debugResult)
        }
    }
    
    public func setDebugEndpoint(_ endpoint: ApiEndpoint) {
        debugEndpoint = endpoint
    }
    
    // MARK: Handle auxiliars
    private func handleDebug() -> Result<T, APIError>? {
        var result: Result<T, APIError>? = nil
        if let debugEndpoint = debugEndpoint {
            guard let url = debugEndpoint.getURL() else {
                return .failure(.urlNotFound)
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                result = self.handleSession(data, response, error)
            }.resume()
        }
        return result
    }
    
    private func handleSession(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<T, APIError> {
        if let _ = error {
            return .failure(.internetConection)
        }

        guard let _ = self.handleResponse(response: response) else {
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
    
    private func handleResponse(response: URLResponse?) -> HTTPURLResponse? {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            return nil
        }
        return httpResponse
    }
}
