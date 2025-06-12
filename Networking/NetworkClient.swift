import Foundation

enum NetworkError: Error {
    case notAuthenticated
}

struct NetworkClient {
    let baseURL: URL

    /// Builds a request for the given API endpoint ensuring an up-to-date
    /// authentication token is used. The completion handler is executed on the
    /// main queue.
    func buildRequest(endpoint: String,
                      completion: @escaping (Result<URLRequest, Error>) -> Void) {
        TokenRefresher.ensureFreshToken { result in
            switch result {
            case .success(let token):
                let url = self.baseURL.appendingPathComponent(endpoint)
                var request = URLRequest(url: url)
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                completion(.success(request))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
