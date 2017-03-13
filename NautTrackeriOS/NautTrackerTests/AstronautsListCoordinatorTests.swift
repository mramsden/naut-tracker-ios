import XCTest
@testable import NautTrackeriOS

final class AstronautsListCoordinatorTests: XCTestCase {

    func testCreatesMainWindow() {
        let coordinator = TestAstronautsListCoordinator()
        let window = coordinator.makeMainWindow(frame: .zero)
        XCTAssertEqual(window.frame, .zero)
    }

}

final class TestAstronautsListCoordinator: AstronautsListCoordinator {}
