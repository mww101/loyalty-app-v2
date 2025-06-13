# Loyalty App

This repository contains a minimal SwiftUI based application structured as a Swift Package.
It targets iOS 15 and later. The package can be opened directly in Xcode or built on the
command line using Swift Package Manager.

## Getting Started

1. Open the project folder in **Xcode 15** or later using `File > Open...` and select the
   `Package.swift` manifest.
2. Choose an iOS simulator and build/run the `LoyaltyApp` scheme.

Alternatively, from a macOS terminal you can build and test the package with:

```bash
swift build
swift test
```

The app launches `LoginView` which stores a JWT token in the Keychain using
`KeychainAccess` and then displays loyalty information via `LoyaltyView`.
