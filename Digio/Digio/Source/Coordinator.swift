import UIKit

public protocol CoordinatorProtocol: AnyObject {
    func show(data: String)
}

final class Coordinator {
    var viewController: UIViewController?
    
    init(){}
}

extension Coordinator: CoordinatorProtocol {
    func show(data: String) {
        print(data)
        viewController?.view.backgroundColor = .green
    }
}
