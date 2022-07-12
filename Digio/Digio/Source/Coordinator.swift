import UIKit

public protocol CoordinatorProtocol: AnyObject {
    func goToDetail(of model: ImagePresentationViewModel)
}

final class Coordinator {
    var viewController: UIViewController?
    var dependency: HasMainQueue
    
    init(dependency: HasMainQueue) {
        self.dependency = dependency
    }
}

extension Coordinator: CoordinatorProtocol {
    func goToDetail(of model: ImagePresentationViewModel) {
        // TODO
    }
}
