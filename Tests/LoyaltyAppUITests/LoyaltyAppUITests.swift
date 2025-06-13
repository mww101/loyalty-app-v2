import XCTest

final class LoyaltyAppUITests: XCTestCase {
    func testLaunch() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.textFields["Email"].exists)
    }
}
