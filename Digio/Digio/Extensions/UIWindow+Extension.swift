import UIKit

extension UIWindow {
    func setupInitialViewController() {
        makeKeyAndVisible()
        rootViewController = AppOrchestrator.makeHome()
    }
}
