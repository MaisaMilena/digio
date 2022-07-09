public protocol ServiceProtocol: AnyObject {
    func fetch() -> String
}

final class Service {
    
}

extension Service: ServiceProtocol {
    func fetch() -> String {
        "hi from Service!"
    }
}
