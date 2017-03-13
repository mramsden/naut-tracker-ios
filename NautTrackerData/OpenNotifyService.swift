import Foundation

public enum OpenNotifyServiceError: Error {
    case transportOffline
    case serviceError
}

public struct OpenNotifyService {

    let client: OpenNotifyClient

    func fetchAstronauts(completion: @escaping ([Astronaut]?, OpenNotifyServiceError?) -> Void) {
        client.fetchAstronauts { data, error in
            if let error = error {
                switch error {
                case .networkOffline: return completion(nil, .transportOffline)
                case .networkTimeout: return completion(nil, .transportOffline)
                default: return completion(nil, .serviceError)
                }
            }

            guard let data = data, let people = data["people"] as? [[String: Any]] else {
                return completion(nil, .serviceError)
            }

            let astronauts: [Astronaut]? = try? people.map(Astronaut.init)
            completion(astronauts, nil)
        }
    }

}
