import XCTest
@testable import NautTrackerData

final class OpenNotifyServiceTests: XCTestCase {

    func testFetchAstronauts() {
        var astronauts: [Astronaut]? = nil
        let client = TestClient(data: ["people": [
            [
                "name": "Neil Armstrong",
                "craft": "Apollo 11"
            ]
        ]])
        let service = OpenNotifyService(client: client)
        
        service.fetchAstronauts() { result, _ in
            astronauts = result
        }

        XCTAssertEqual(astronauts?.count, 1)
        XCTAssertEqual(astronauts?.first?.name, "Neil Armstrong")
        XCTAssertEqual(astronauts?.first?.craft, "Apollo 11")
    }

    func testFetchAstronautsReturnsClientErrorIfUnknownNetworkErrorOccurs() {
        let client = TestClient(error: .unknown)
        let service = OpenNotifyService(client: client)

        service.fetchAstronauts { _, error in
            XCTAssertTrue(error == .serviceError, "Expected a serviceError error when unkwown error encountered")
        }
    }

    func testFetchAstronautsReturnsTransportOfflineIfNetworkOffline() {
        let client = TestClient(error: .networkOffline)
        let service = OpenNotifyService(client: client)

        service.fetchAstronauts { _, error in
            XCTAssertTrue(error == .transportOffline, "Expected a transportOffline error when network offline")
        }
    }

    func testFetchAstronautsReturnsTransportOfflineIfNetworkTimeout() {
        let client = TestClient(error: .networkTimeout)
        let service = OpenNotifyService(client: client)

        service.fetchAstronauts { _, error in
            XCTAssertTrue(error == .transportOffline, "Expected a transportOffline error when network times out")
        }
    }

}

private struct TestClient: OpenNotifyClient {

    let error: OpenNotifyClientError?
    let data: [String: Any]?

    init(data: [String: Any]? = nil, error: OpenNotifyClientError? = nil) {
        self.data = data
        self.error = error
    }

    func fetchAstronauts(completion: ([String: Any]?, OpenNotifyClientError?) -> Void) {
        completion(data, error)
    }

}
