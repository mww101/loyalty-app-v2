import Foundation
import KeychainAccess

enum KeychainManager {
    private static let keychain = Keychain()
    
    private enum Keys {
        static let email = "email"
        static let token = "jwtToken"
        static let tokenDate = "tokenDate"
    }

    static func saveEmail(_ email: String) {
        do {
            try keychain.set(email, key: Keys.email)
        } catch {
            print("Keychain saveEmail error: \(error)")
        }
    }

    static func getEmail() -> String? {
        do {
            return try keychain.get(Keys.email)
        } catch {
            print("Keychain getEmail error: \(error)")
            return nil
        }
    }

    static func saveToken(_ token: String, date: Date) {
        do {
            try keychain.set(token, key: Keys.token)
            let interval = String(date.timeIntervalSince1970)
            try keychain.set(interval, key: Keys.tokenDate)
        } catch {
            print("Keychain saveToken error: \(error)")
        }
    }

    static func getToken() -> (token: String, date: Date)? {
        do {
            guard let token = try keychain.get(Keys.token),
                  let intervalStr = try keychain.get(Keys.tokenDate),
                  let interval = TimeInterval(intervalStr) else {
                return nil
            }
            return (token, Date(timeIntervalSince1970: interval))
        } catch {
            print("Keychain getToken error: \(error)")
            return nil
        }
    }
}
