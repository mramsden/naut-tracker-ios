import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let astronautsListCoordinator: AstronautsListCoordinator
    var window: UIWindow? = nil

    override init() {
        self.astronautsListCoordinator = DefaultAstronautsListCoordinator()
    }

    init(astronautsListCoordinator: AstronautsListCoordinator) {
        self.astronautsListCoordinator = astronautsListCoordinator
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        guard self.window == nil else { return }

        let window = astronautsListCoordinator.makeMainWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
    }

}
