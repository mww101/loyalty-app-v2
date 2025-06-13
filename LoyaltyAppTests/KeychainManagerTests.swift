import XCTest
@testable import LoyaltyApp

final class KeychainManagerTests: XCTestCase {
    func testSaveAndGetEmail() {
        KeychainManager.saveEmail("user@example.com")
        XCTAssertEqual(KeychainManager.getEmail(), "user@example.com")
    }

    func testSaveAndGetToken() {
        let now = Date()
        KeychainManager.saveToken("TOKEN123", date: now)
        let tokenInfo = KeychainManager.getToken()
        XCTAssertEqual(tokenInfo?.token, "TOKEN123")
        XCTAssertNotNil(tokenInfo)
        if let date = tokenInfo?.date {
            XCTAssertLessThan(abs(date.timeIntervalSince(now)), 1)
        }
    }
}
