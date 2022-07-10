import UIKit

public protocol CoordinatorProtocol: AnyObject {
    func show(data: String)
}

final class Coordinator {
    var viewController: UIViewController?
    var dependency: HasMainQueue
    
    init(dependency: HasMainQueue) {
        self.dependency = dependency
    }
}

extension Coordinator: CoordinatorProtocol {
    func show(data: String) {
        Sentinel.info(data)
        dependency.mainQueue.async {
            self.viewController?.view.backgroundColor = .green
        }
    }
}
