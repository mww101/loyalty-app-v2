import Foundation

/// Mirrors the real GoodtillAPI signatures but returns dummy data.
struct MockGoodtillAPI {
    // Delay before returning mock token
    private static let responseDelay: TimeInterval = 0.5

    /// Simulates signing in by returning a hard-coded token after a short delay.
    static func signIn(email: String,
                       completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            completion(.success("MOCK_TOKEN_ABC"))
        }
    }

    /// Simulates refreshing the token by returning a new mock token.
    static func refreshToken(oldToken: String,
                             completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            completion(.success("MOCK_TOKEN_DEF"))
        }
    }

    /// Simulates fetching a customer, returning a dummy Customer.
    static func fetchCustomer(email: String,
                              completion: @escaping (Result<Customer, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + responseDelay) {
            let customer = Customer(id: "MOCK_ID_123", loyalty_points: 750)
            completion(.success(customer))
        }
    }
}

/// Same model as in GoodtillAPI
struct Customer: Decodable {
    let id: String
    let loyalty_points: Int
}
