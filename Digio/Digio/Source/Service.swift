public protocol ServiceProtocol: AnyObject {
    func fetch(completion: @escaping (Result<HomeData, APIError>) -> Void)
}

final class Service {}

extension Service: ServiceProtocol {
    func fetch(completion: @escaping (Result<HomeData, APIError>) -> Void) {
        Sentinel.event("start")
        let api = setupApi()
        api.execute { result in
            Sentinel.event("got result")
            completion(result)
        }
        Sentinel.error("end")
    }
    
    private func setupApi() -> Api<HomeData> {
        let endpoint = Endpoint()
        let debugEndpoint = Endpoint(path: "127.0.0.1:3001", method: .get)
        let api = Api<HomeData>.init(endpoint: endpoint)
        api.setDebugEndpoint(debugEndpoint)
        return api
    }
}

