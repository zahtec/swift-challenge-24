import UIKit

// MARK: Miara' app delegate that locks the rotation to portrait mode
final class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
		return .portrait
	}
}
