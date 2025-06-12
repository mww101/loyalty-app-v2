import Foundation

/// Responsible for ensuring the saved authentication token is valid. If the
token is close to expiration a refresh will be attempted.
struct TokenRefresher {
    /// Tokens are refreshed when less than five minutes remain before expiry.
    static let refreshThreshold: TimeInterval = 5 * 60

    /// Ensures a fresh token is available and returns it via the completion
    /// handler. The callback is always invoked on the main queue.
    static func ensureFreshToken(completion: @escaping (Result<String, Error>) -> Void) {
        guard let (token, date) = KeychainManager.getToken() else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.notAuthenticated))
            }
            return
        }

        let timeSince = Date().timeIntervalSince(date)
        // Assume tokens are valid for 12 hours.
        if timeSince < (12 * 60 * 60 - refreshThreshold) {
            DispatchQueue.main.async {
                completion(.success(token))
            }
            return
        }

        GoodtillAPI.refreshToken(oldToken: token) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newToken):
                    KeychainManager.saveToken(newToken, date: Date())
                    completion(.success(newToken))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
