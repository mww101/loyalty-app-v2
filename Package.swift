// swift-tools-version:5.7
 import PackageDescription

let package = Package(
    name: "LoyaltyApp",
    platforms: [.iOS(.v16)],
       
    
        products: [
            .executable(name: "LoyaltyApp", targets: ["LoyaltyApp"])
        ],
    dependencies: [
        // Keychain helper
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            .upToNextMinor(from: "4.2.2")
        )
    ],
    targets: [
        // Main app code lives in LoyaltyApp/
        .executableTarget(
            name: "LoyaltyApp",
            dependencies: [
              .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "LoyaltyApp"
          ),

        // Unit tests in LoyaltyAppTests/
        .testTarget(
            name: "LoyaltyAppTests",
            dependencies: ["LoyaltyApp"],
            path: "LoyaltyAppTests"
        ),

        // UI tests in LoyaltyAppUITests/
        .testTarget(
            name: "LoyaltyAppUITests",
            dependencies: ["LoyaltyApp"],
            path: "LoyaltyAppUITests"
        )
    ]
)
