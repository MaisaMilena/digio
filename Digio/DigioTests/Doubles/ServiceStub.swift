import Digio

final class ServiceStub: ServiceProtocol {
    private var response: HomeData?
    private var error: APIError?
    private(set) var fetchCount = 0

    func stubResponse(_ response: HomeData) {
        self.response = response
    }

    func stubError(_ error: APIError) {
        self.error = error
    }

    func fetch(completion: @escaping (Result<HomeData, APIError>) -> Void) {
        fetchCount += 1
        if let error = error {
            completion(.failure(error))
        } else if let response = response {
            completion(.success(response))
        }
    }
}
