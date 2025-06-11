// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "LoyaltyApp",
    platforms: [
        .iOS("18.0")
    ],
    products: [
        .executable(name: "LoyaltyApp", targets: ["LoyaltyApp"])
    ],
    targets: [
        .executableTarget(
            name: "LoyaltyApp",
            path: "LoyaltyApp"
        )
    ]
)
