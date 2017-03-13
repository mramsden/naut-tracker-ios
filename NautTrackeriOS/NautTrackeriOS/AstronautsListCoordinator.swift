import UIKit

protocol AstronautsListCoordinator {

    func makeMainWindow(frame: CGRect) -> UIWindow

}

extension AstronautsListCoordinator {

    func makeMainWindow(frame: CGRect) -> UIWindow {
        let window = UIWindow(frame: frame)
        window.backgroundColor = .red

        var interactor = DefaultAstronautsInteractor(presenter: DefaultAstronautsListPresenter())
        let viewController = AstronautsViewController(interactor: interactor)

        interactor.presenter.view = viewController

        window.rootViewController = viewController

        return window
    }

}

struct DefaultAstronautsListCoordinator: AstronautsListCoordinator {

}
