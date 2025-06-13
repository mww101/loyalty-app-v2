import SwiftUI

struct ContentView: View {
  @State private var email: String = ""
  @State private var tokenInfo: (token: String, date: Date)?

  var body: some View {
    VStack(spacing: 16) {
      TextField("Enter email", text: $email)
        .textFieldStyle(.roundedBorder)
        .padding()

      Button("Save Email") {
        KeychainManager.saveEmail(email)
      }

      Button("Load Email") {
        email = KeychainManager.getEmail() ?? "nil"
      }

      if let info = tokenInfo {
        Text("Token: \(info.token)")
          if #available(iOS 15.0, *) {
              Text("Saved on: \(info.date.formatted())")
          } else {
              // Fallback on earlier versions
          }
      }

      Button("Test Token") {
        KeychainManager.saveToken("ABC123", date: Date())
        tokenInfo = KeychainManager.getToken()
      }
    }
    .padding()
  }
}
