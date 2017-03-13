import Foundation

enum AstronautError: Error {
    case badData
}

public struct Astronaut {
    public let name: String
    public let craft: String

    init(name: String, craft: String) {
        self.name = name
        self.craft = craft
    }

    init(dictionary: [String: Any]) throws {
        guard let name = dictionary["name"] as? String, let craft = dictionary["craft"] as? String else {
            throw AstronautError.badData
        }

        self.init(name: name, craft: craft)
    }
}
