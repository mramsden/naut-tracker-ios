import XCTest
@testable import NautTrackerData

final class NSURLSession_OpenNotifyClientTests: XCTestCase {

    func testCompletesWithDataIfResponseIsValid() {
        var completed = false
        let data = "{\"people\": [{\"craft\": \"Apollo 11\", \"name\": \"Neil Armstrong\"}], \"message\": \"success\", \"number\": 6}".data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "http://api.open-notify.org/astros.json")!, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!

        let session = TestURLSession(data: data, response: response)
        session.fetchAstronauts { data, _ in
            completed = true
            XCTAssertNotNil(data)
        }
        XCTAssertTrue(completed, "Expected completion to be invoked")
    }

    func testUnknownMimeTypeCompletesWithUnknownError() {
        var completed = false
        let response = HTTPURLResponse(url: URL(string: "http://api.open-notify.org/astros.json")!, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "text/plain"])!

        let session = TestURLSession(data: Data(), response: response)
        session.fetchAstronauts { _, error in
            completed = true
            XCTAssertTrue(error == .unknown)
        }
        XCTAssertTrue(completed, "Expected completion to be invoked")
    }

    func testNetworkOfflineErrorCompletesWithNetworkOfflineError() {
        var completed = false
        let session = TestURLSession(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil))
        session.fetchAstronauts { _, error in
            completed = true
            XCTAssertTrue(error == .networkOffline)
        }
        XCTAssertTrue(completed, "Expected completion to be invoked")
    }

    func testNetworkTimeoutErrorCompletesWithNetworkTimeoutError() {
        var completed = false
        let session = TestURLSession(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil))
        session.fetchAstronauts { _, error in
            completed = true
            XCTAssertTrue(error == .networkTimeout)
        }
        XCTAssertTrue(completed, "Expected completion to be invoked")
    }

    func testAnyErrorResultsInUnknownError() {
        var completed = false
        let session = TestURLSession(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil))
        session.fetchAstronauts { _, error in
            completed = true
            XCTAssertTrue(error == .unknown)
        }
        XCTAssertTrue(completed, "Expected completion to be invoked")
    }

}

final class TestURLSessionDataTask: URLSessionDataTask {

    var isResumed = false

    override func resume() {
        isResumed = true
    }

    override func suspend() {
        isResumed = false
    }

}

final class TestURLSession: URLSession {

    private var data: Data?
    private var response: URLResponse?
    private var error: Error?

    init(data: Data, response: URLResponse) {
        super.init()
        self.data = data
        self.response = response
        self.error = nil
    }

    init(error: Error? = nil) {
        super.init()
        self.data = nil
        self.response = nil
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return TestURLSessionDataTask()
    }

}
