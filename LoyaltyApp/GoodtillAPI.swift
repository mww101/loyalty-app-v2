import Foundation

struct GoodtillAPI {
    static let baseURL = URL(string: "https://api.goodtill.example.com")!

    private struct TokenResponse: Decodable {
        let token: String
    }

    private struct TokenRequest: Encodable {
        let token: String
    }

    struct Customer: Decodable {
        let id: String
        let loyalty_points: Int
    }

    static func signIn(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        let client = NetworkClient(baseURL: baseURL)
        client.buildRequest(endpoint: "signin?email=\(email)") { result in
            switch result {
            case .success(let request):
                URLSession.shared.dataTask(with: request) { data, _, error in
                    if let error = error {
                        DispatchQueue.main.async { completion(.failure(error)) }
                        return
                    }
                    guard let data = data else {
                        DispatchQueue.main.async { completion(.failure(URLError(.badServerResponse))) }
                        return
                    }
                    do {
                        let token = try JSONDecoder().decode(TokenResponse.self, from: data).token
                        DispatchQueue.main.async { completion(.success(token)) }
                    } catch {
                        DispatchQueue.main.async { completion(.failure(error)) }
                    }
                }.resume()
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }

    static func refreshToken(oldToken: String, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("refresh"))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = TokenRequest(token: oldToken)
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            DispatchQueue.main.async { completion(.failure(error)) }
            return
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(URLError(.badServerResponse))) }
                return
            }
            do {
                let token = try JSONDecoder().decode(TokenResponse.self, from: data).token
                DispatchQueue.main.async { completion(.success(token)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }

    static func fetchCustomer(email: String, completion: @escaping (Result<Customer, Error>) -> Void) {
        let client = NetworkClient(baseURL: baseURL)
        client.buildRequest(endpoint: "customers?search=\(email)") { result in
            switch result {
            case .success(let request):
                URLSession.shared.dataTask(with: request) { data, _, error in
                    if let error = error {
                        DispatchQueue.main.async { completion(.failure(error)) }
                        return
                    }
                    guard let data = data else {
                        DispatchQueue.main.async { completion(.failure(URLError(.badServerResponse))) }
                        return
                    }
                    do {
                        let customer = try JSONDecoder().decode(Customer.self, from: data)
                        DispatchQueue.main.async { completion(.success(customer)) }
                    } catch {
                        DispatchQueue.main.async { completion(.failure(error)) }
                    }
                }.resume()
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
}

