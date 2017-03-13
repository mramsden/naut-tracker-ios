import Foundation

protocol AstronautsInteractor {

    var presenter: AstronautsListPresenter { get set }

}

struct DefaultAstronautsInteractor: AstronautsInteractor {

    var presenter: AstronautsListPresenter

}
