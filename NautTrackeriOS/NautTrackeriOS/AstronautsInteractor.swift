import Foundation
import NautTrackerData

protocol AstronautsInteractor {

    var presenter: AstronautsPresenter { get set }

    func fetchAstronauts()

}

struct DefaultAstronautsInteractor: AstronautsInteractor {

    var presenter: AstronautsPresenter

    func fetchAstronauts() {
        presenter.loadingDidStart()
        let service = OpenNotifyService(client: URLSession(configuration: .ephemeral))
        service.fetchAstronauts { astronauts, error in
            self.presenter.didLoad(astronauts: astronauts ?? [])
        }
    }

}
