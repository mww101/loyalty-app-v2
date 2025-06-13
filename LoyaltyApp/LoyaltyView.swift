import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

@available(iOS 15.0, *)
struct LoyaltyView: View {
    @State private var points: Int?
    @State private var pounds: String = ""
    @State private var qrImage: Image?
    @State private var errorMessage: String?

    var body: some View {
        Group {
            if let points {
                VStack(spacing: 20) {
                    Text("You have \(points) pts (~\(pounds))")
                        .accessibilityIdentifier("pointsLabel")
                    if let qrImage {
                        qrImage
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    }
                    Button("Refresh") { loadData() }
                }
            } else {
                ProgressView()
                    .onAppear { loadData() }
            }
        }
        .alert("Error", isPresented: Binding(get: { errorMessage != nil }, set: { _ in errorMessage = nil })) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage ?? "")
        }
    }

    private func loadData() {
        guard let email = KeychainManager.getEmail() else {
            errorMessage = "No email found"
            return
        }

        DispatchQueue.global(qos: .background).async {
            MockGoodtillAPI.fetchCustomer(email: email) { result in
                switch result {
                case .success(let customer):
                    let pts = customer.loyalty_points
                    let lbs = Double(pts) / 100
                    let formatted = NumberFormatter.localizedString(from: NSNumber(value: lbs), number: .currency)
                    let filter = CIFilter.qrCodeGenerator()
                    filter.message = Data(customer.id.utf8)
                    let ciImage = filter.outputImage!.transformed(by: CGAffineTransform(scaleX: 10, y: 10))
                    let uiImage = UIImage(ciImage: ciImage)
                    let image = Image(uiImage: uiImage)
                    DispatchQueue.main.async {
                        self.points = pts
                        self.pounds = formatted
                        self.qrImage = image
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}

#Preview {
    LoyaltyView()
}
