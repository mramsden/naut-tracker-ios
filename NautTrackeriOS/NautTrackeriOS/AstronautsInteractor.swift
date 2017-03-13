import Foundation

protocol AstronautsInteractor {

    var presenter: AstronautsPresenter { get set }

    func fetchAstronauts()

}

struct DefaultAstronautsInteractor: AstronautsInteractor {

    var presenter: AstronautsPresenter

    func fetchAstronauts() {
        presenter.loadingDidStart()
    }

}
