import UIKit

extension UIWindow {
    func setupInitialViewController() {
        makeKeyAndVisible()
        rootViewController = ViewController()
    }
}
