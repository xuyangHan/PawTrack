import XCTest

final class PawTrackUITests: XCTestCase {
    func testSmokeLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.exists)
    }
}
