import XCTest
@testable import NautTrackeriOS

final class AppDelegateTests: XCTestCase {

    func testApplicationBecomingActiveAttachesWindow() {
        let delegate = AppDelegate()
        delegate.applicationDidBecomeActive(UIApplication.shared)
        XCTAssertNotNil(delegate.window)
    }

    func testApplicationBecomingActiveDoesNotReattachWindow() {
        let window = UIWindow(frame: .zero)
        let delegate = AppDelegate()
        delegate.window = window
        delegate.applicationDidBecomeActive(UIApplication.shared)
        XCTAssertEqual(delegate.window, window)
    }

}
