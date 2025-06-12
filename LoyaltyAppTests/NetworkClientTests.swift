import XCTest
@testable import LoyaltyApp

final class NetworkClientTests: XCTestCase {
    func testBuildRequestAddsAuthorizationHeader() throws {
        // Store a fake token so TokenRefresher finds it
        KeychainManager.saveToken("FAKE_TOKEN", date: Date())

        let expectation = expectation(description: "buildRequest")
        let client = NetworkClient(baseURL: URL(string: "https://example.com")!)
        var builtRequest: URLRequest?
        client.buildRequest(endpoint: "test") { result in
            builtRequest = try? result.get()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        let request = try XCTUnwrap(builtRequest)
        XCTAssertTrue(request.url?.absoluteString.hasSuffix("/test") ?? false)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer FAKE_TOKEN")
    }
}
