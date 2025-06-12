import XCTest

final class LoginFlowTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testLoginAndShowLoyalty() throws {
        let app = XCUIApplication()

        // 1. Enter email
        let emailField = app.textFields["Email"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 2))
        emailField.tap()
        emailField.typeText("test@example.com")

        // 2. Tap Sign In
        app.buttons["Sign In"].tap()

        // 3. Verify loyalty screen
        let ptsLabel = app.staticTexts["You have 750 pts (~£7.50)"]
        XCTAssertTrue(ptsLabel.waitForExistence(timeout: 2))

        // 4. Tap Refresh and re-check
        app.buttons["Refresh"].tap()
        XCTAssertTrue(ptsLabel.exists)
    }
}
