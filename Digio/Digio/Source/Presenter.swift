public protocol PresenterProtocol: AnyObject {
    func show(data: String)
}

final class Presenter {
    private let coordinator: CoordinatorProtocol
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension Presenter: PresenterProtocol {
    func show(data: String) {
        coordinator.show(data: data)
    }
}
