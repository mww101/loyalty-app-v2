// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "LoyaltyApp",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "LoyaltyApp",
            targets: ["LoyaltyApp"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .exact("4.2.2"))
    ],
    targets: [
        .target(
            name: "Networking",
            path: "Networking"
        ),
        .target(
            name: "LoyaltyApp",
            dependencies: [
                "Networking",
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "LoyaltyApp"
        )
    ]
)
