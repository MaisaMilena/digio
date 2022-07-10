public protocol ServiceProtocol: AnyObject {
    func fetch(completion: @escaping (Result<HomeData, APIError>) -> Void)
}

final class Service {
    private var dependency: HasMainQueue
    init(dependency: HasMainQueue) {
        self.dependency = dependency
    }
}

extension Service: ServiceProtocol {
    func fetch(completion: @escaping (Result<HomeData, APIError>) -> Void) {
        let api = setupApi()
        dependency.mainQueue.async {
            api.execute { result in
                Sentinel.event("got result")
                completion(result)
            }
        }
    }
    
    private func setupApi() -> Api<HomeData> {
        let endpoint = Endpoint()
        let debugEndpoint = Endpoint(path: "http://127.0.0.1:3001", method: .get)
        let api = Api<HomeData>.init(endpoint: endpoint)
        api.setDebugEndpoint(debugEndpoint)
        return api
    }
}
