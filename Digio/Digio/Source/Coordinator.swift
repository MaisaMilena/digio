import UIKit

public protocol CoordinatorProtocol: AnyObject {
    func showHighligths(viewModels: [SpotlightView])
}

final class Coordinator {
    var viewController: UIViewController?
    var dependency: HasMainQueue
    
    init(dependency: HasMainQueue) {
        self.dependency = dependency
    }
}

extension Coordinator: CoordinatorProtocol {
    func showHighligths(viewModels: [SpotlightView]) {
        
    }
    
    func show(data: String) {
        Sentinel.info(data)
        dependency.mainQueue.async {
            self.viewController?.view.backgroundColor = .green
        }
    }
}
