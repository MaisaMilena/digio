public protocol InteractorProtocol: AnyObject {
    func fetch()
}

final class Interactor {
    private let presenter: PresenterProtocol
    private let service: ServiceProtocol
    
    init(presenter: PresenterProtocol, service: ServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
}

extension Interactor: InteractorProtocol {
    func fetch() {
        let result = service.fetch()
        presenter.show(data: result)
    }
}
