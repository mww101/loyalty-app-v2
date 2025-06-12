import XCTest

final class LoginFlowTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    func testLoginAndDisplayLoyaltyFlow() throws {
        let app = XCUIApplication()
        let emailField = app.textFields["emailField"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 2))
        emailField.tap()
        emailField.typeText("test@example.com")

        app.buttons["signInButton"].tap()

        let ptsLabel = app.staticTexts["pointsLabel"]
        XCTAssertTrue(ptsLabel.waitForExistence(timeout: 5))
        app.buttons["Refresh"].tap()

        XCTAssertTrue(ptsLabel.exists)
    }
}
