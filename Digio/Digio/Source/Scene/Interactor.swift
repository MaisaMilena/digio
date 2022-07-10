public protocol InteractorProtocol: AnyObject {
    func fetch()
}

final class Interactor {
    private let presenter: PresenterProtocol
    private let service: ServiceProtocol
    private var data: HomeData?
    
    init(presenter: PresenterProtocol, service: ServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
}

extension Interactor: InteractorProtocol {
    func fetch() {
        service.fetch { [weak self] result in
            switch result {
            case let .success(data):
                self?.data = data
                self?.presenter.show(data: data)
            case let .failure(error):
                Sentinel.error(error.description)
            }
        }
    }
}
