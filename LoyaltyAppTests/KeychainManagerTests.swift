import XCTest
@testable import LoyaltyApp

final class KeychainManagerTests: XCTestCase {
    func testSaveAndGetEmail() throws {
        KeychainManager.saveEmail("test@example.com")
        XCTAssertEqual(KeychainManager.getEmail(), "test@example.com")
    }

    func testSaveAndGetToken() throws {
        let date = Date(timeIntervalSince1970: 0)
        KeychainManager.saveToken("TOKEN123", date: date)
        let result = KeychainManager.getToken()
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.token, "TOKEN123")
        XCTAssertEqual(result?.date, date)
    }
}
