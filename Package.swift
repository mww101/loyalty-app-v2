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
    dependencies: [
        .package(url: "https://github.com/BlockchainCommons/QRCodeGenerator", from: "3.0.1"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess", from: "4.2.2"),
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.8.1")
    ],
    targets: [
        .executableTarget(
            name: "LoyaltyApp",
            dependencies: [
                "QRCodeGenerator",
                "KeychainAccess",
                "CombineExt"
            ],
            path: "LoyaltyApp"
        )
    ]
)
