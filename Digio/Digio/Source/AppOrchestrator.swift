import UIKit

enum AppOrchestrator {
    static func makeHome() -> UIViewController {
        let coordinator = Coordinator()
        let presenter = Presenter(coordinator: coordinator)
        let service = Service()
        let interactor = Interactor(presenter: presenter, service: service)
        let viewController = ViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        
        return viewController
    }
}
