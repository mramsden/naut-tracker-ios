import Foundation
import NautTrackerData

protocol AstronautsPresenterOutputHandler: class {

    func state(didChangeTo: AstronautsPresenterState)

}

enum AstronautsPresenterState {
    case empty
    case loading
    case loaded([Astronaut])
}

protocol AstronautsPresenter {

    weak var outputHandler: AstronautsPresenterOutputHandler? { get set }

    func loadingDidStart()
    func didLoad(astronauts: [Astronaut])

}

class DefaultAstronautsPresenter: AstronautsPresenter {

    weak var outputHandler: AstronautsPresenterOutputHandler?

    func loadingDidStart() {
        DispatchQueue.main.async {
            self.outputHandler?.state(didChangeTo: .loading)
        }
    }

    func didLoad(astronauts: [Astronaut]) {
        DispatchQueue.main.async {
            self.outputHandler?.state(didChangeTo: .loaded(astronauts))
        }
    }

}
