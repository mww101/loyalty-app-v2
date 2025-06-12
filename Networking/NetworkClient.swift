import Foundation

enum NetworkError: Error {
    case notAuthenticated
}

struct NetworkClient {
    let baseURL: URL

    func buildRequest(endpoint: String) throws -> URLRequest {
        guard let (token, _) = KeychainManager.getToken() else {
            throw NetworkError.notAuthenticated
        }
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
