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
        let result = service.fetch { [weak self] result in
            switch result {
                case let .success(data):
                    Sentinel.info(data.cash.title)
                case let .failure(error):
                    Sentinel.error(error.description)
            }
        }
        presenter.show(data: "na Interactor")
    }
}
