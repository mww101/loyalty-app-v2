import XCTest

final class LoyaltyAppUITestsLaunchTests: XCTestCase {
    func testLaunchShowsEmailField() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.textFields["Email"].exists)
    }
}
