import XCTest
@testable import NautTrackerData

final class AstronautTests: XCTestCase {

    func testCreateAstronaut() {
        let name = "Neil Armstrong"
        let craft = "Apollo 11"

        let astronaut = Astronaut(name: name, craft: craft)
        
        XCTAssertEqual(astronaut.name, name)
        XCTAssertEqual(astronaut.craft, craft)
    }

    func testCreateAstronautWithDictionary() {
        let name = "Neil Armstrong"
        let craft = "Apollo 11"

        let astronaut = try? Astronaut(dictionary: ["name": name, "craft": craft])

        XCTAssertEqual(astronaut?.name, name)
        XCTAssertEqual(astronaut?.craft, craft)
    }

    func testThrowsInvalidDataExceptionIfDictionaryInvalid() {
        try? XCTAssertThrowsError(Astronaut(dictionary: [:])) { error in
            XCTAssertTrue((error as? AstronautError) == .badData, "Expected a badData AstronautError")
        }
    }

}
