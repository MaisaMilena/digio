import UIKit

extension UIWindow {
    func setupInitialViewController() {
        rootViewController = ViewController()
        makeKeyAndVisible()
    }
}
