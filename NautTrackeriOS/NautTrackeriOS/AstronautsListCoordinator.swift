import UIKit

protocol AstronautsListCoordinator {

    func makeMainWindow(frame: CGRect) -> UIWindow

}

extension AstronautsListCoordinator {

    func makeMainWindow(frame: CGRect) -> UIWindow {
        let window = UIWindow(frame: frame)

        var interactor = DefaultAstronautsInteractor(presenter: DefaultAstronautsPresenter())
        let viewController = AstronautsViewController(interactor: interactor)

        interactor.presenter.outputHandler = viewController

        window.rootViewController = viewController

        return window
    }

}

struct DefaultAstronautsListCoordinator: AstronautsListCoordinator {

}
