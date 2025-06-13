// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "LoyaltyApp",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "LoyaltyApp",
            targets: ["LoyaltyApp"]
        )
    ],
    dependencies: [
        // Keychain helper
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            .upToNextMinor(from: "4.2.2")
        )
    ],
    targets: [
        // Main app code
        .target(
            name: "LoyaltyApp",
            dependencies: [
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "LoyaltyApp"
        ),

        // Unit tests
        .testTarget(
            name: "LoyaltyAppTests",
            dependencies: ["LoyaltyApp"],
            path: "LoyaltyAppTests"
        ),

        // UI tests
        .testTarget(
            name: "LoyaltyAppUITests",
            dependencies: ["LoyaltyApp"],
            path: "LoyaltyAppUITests"
        )
    ]
)
