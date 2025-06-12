import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigate: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                Button("Sign In") {
                    signIn()
                }
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
    }

    @MainActor
    private func signIn() {
        GoodtillAPI.signIn(email: email) { result in
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
