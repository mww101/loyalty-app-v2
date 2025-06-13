import SwiftUI

@available(iOS 15.0, *)
struct LoginView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigate: Bool = false

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .accessibilityIdentifier("emailField")
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                    Button("Sign In") {
                        signIn()
                    }
                    .accessibilityIdentifier("signInButton")
                }
                .padding()
                .alert("Error", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }
                .navigationDestination(isPresented: $navigate) {
                    LoyaltyView()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    @MainActor
    private func signIn() {
        MockGoodtillAPI.signIn(email: email) { result in
            switch result {
            case .success(let token):
                KeychainManager.saveEmail(email)
                KeychainManager.saveToken(token, date: Date())
                navigate = true
            case .failure(let error):
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    
    }
}

#Preview {
    LoginView()
}
