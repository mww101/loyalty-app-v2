// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "LoyaltyApp",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "LoyaltyApp",
            targets: ["LoyaltyApp"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            .upToNextMinor(from: "4.2.2")
        )
    ],
    targets: [
        .target(
            name: "LoyaltyApp",
            dependencies: [
                .product(name: "KeychainAccess", package: "KeychainAccess")
            ],
            path: "LoyaltyApp",
            exclude: [
                "Info.plist"
            ],
            resources: [
                .process("../Media.xcassets")
            ]
        ),
        .testTarget(
            name: "LoyaltyAppTests",
            dependencies: ["LoyaltyApp"],
            path: "Tests/LoyaltyAppTests"
        ),
        .testTarget(
            name: "LoyaltyAppUITests",
            dependencies: ["LoyaltyApp"],
            path: "Tests/LoyaltyAppUITests"
        ),
    ]
)
