import XCTest

final class LoginFlowTests: XCTestCase {
    func testLoginFlow() {
        let app = XCUIApplication()
        app.launch()
        let emailField = app.textFields["Email"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 5))
        emailField.tap()
        emailField.typeText("test@example.com")
        app.buttons["Sign In"].tap()
        let points = app.staticTexts["pointsLabel"]
        XCTAssertTrue(points.waitForExistence(timeout: 5))
        XCTAssertTrue(points.label.contains("pts"))
    }
}
