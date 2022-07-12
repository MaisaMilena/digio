import UIKit

enum AppOrchestrator {
    static func makeHome() -> UIViewController {
        let dependencyContainer = DependencieContainer()
        let coordinator = Coordinator(dependency: dependencyContainer)
        let presenter = Presenter(coordinator: coordinator)
        let service = Service(dependency: dependencyContainer)
        let interactor = Interactor(presenter: presenter, service: service)
        let viewController = ViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
