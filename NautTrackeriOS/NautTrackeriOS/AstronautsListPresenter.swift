import Foundation

protocol AstronautsView: class {

}

protocol AstronautsListPresenter {

    weak var view: AstronautsView? { get set }

}

struct DefaultAstronautsListPresenter: AstronautsListPresenter {

    weak var view: AstronautsView?

}
