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

}

class DefaultAstronautsPresenter: AstronautsPresenter {

    weak var outputHandler: AstronautsPresenterOutputHandler?

    func loadingDidStart() {
        outputHandler?.state(didChangeTo: .loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.outputHandler?.state(didChangeTo: .empty)
        }
    }

}
