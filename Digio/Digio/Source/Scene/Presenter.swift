public protocol PresenterProtocol: AnyObject {
    func show(data: HomeData)
}

final class Presenter {
    private let coordinator: CoordinatorProtocol
    private let display: 
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension Presenter: PresenterProtocol {
    func show(data: HomeData) {
        
        coordinator.show(data: data.cash.title)
    }
}
