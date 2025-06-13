import XCTest
@testable import LoyaltyApp

final class NetworkClientTests: XCTestCase {
    func testBuildRequestInjectsHeaderAndURL() {
        KeychainManager.saveToken("HEADER_TOKEN", date: Date())
        let base = URL(string: "https://example.com")!
        let client = NetworkClient(baseURL: base)
        let expectation = self.expectation(description: "request")
        client.buildRequest(endpoint: "path") { result in
            switch result {
            case .success(let request):
                XCTAssertEqual(request.url, base.appendingPathComponent("path"))
                XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "Bearer HEADER_TOKEN")
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
