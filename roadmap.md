Project Roadmap

This document outlines the high-level goals, phases, and architecture for the Loyalty App. It serves as a single source of truth for current status and future plans.

Phase 1: Core Loyalty Flow (MVP)

Objective: Secure, password‑less login; display loyalty points, £-value, and customer QR code.

Login via Magic‑Link

LoginView.swift with:

emailField (TextField) tagged .accessibilityIdentifier("emailField")

sendLinkButton (Button) tagged .accessibilityIdentifier("sendLinkButton")

Call GoodtillAPI.requestLoginCode(email:) → simulates sending a one‑time link

EnterCodeView.swift with:

codeField (TextField) tagged .accessibilityIdentifier("codeField")

verifyButton (Button) tagged .accessibilityIdentifier("verifyButton")

Call GoodtillAPI.verifyLoginCode(email:code:) → returns JWT

Save JWT via KeychainManager.saveToken(_:,date:) and navigate to loyalty screen

Loyalty Screen

LoyaltyView.swift:

Shows pointsLabel:

Text("You have \(points) pts (~\(pounds))")
  .accessibilityIdentifier("pointsLabel")

Generates a QR code image for customer.id

“Refresh” button to reload data

Networking & Security

KeychainManager (email, token, date) using KeychainAccess

NetworkClient + TokenRefresher for JWT with auto‑refresh logic

Endpoints stubbed via MockGoodtillAPI for local development

Testing

Unit Tests for KeychainManager, NetworkClient, TokenRefresher

UI Tests (LoginFlowTests.swift) covering email → code → loyalty flow

CI: GitHub Action running xcodebuild test on each PR

Estimated time: 2–3 hours (now complete)

Phase 2: User Onboarding & Profile

Objective: Enable new users to register and manage their profile.

Registration Flow

RegisterView.swift (email, name, password? or magic‑link)

Backend call: GoodtillAPI.register(...)

Auto‑login on success, reuse Phase 1 flow

Profile Management

ProfileView.swift: shows user details, loyalty tier, edit fields

Sign-out button to clear Keychain and return to login

Session Management Improvements

On app launch, check token age and auto‑refresh

Handle expired tokens by redirecting to login

Unit tests for registration logic and session handling

Estimated time: 2–3 hours

Phase 3: Store Locator & Promotions

StoresView.swift: list of outlets via GoodtillAPI.fetchStores()

StoreDetailView.swift with segmented control:

Home, Rewards, Points, Receipts tabs

Fetch and display promotions, rewards catalog, and transaction history

UI tests for navigation across tabs

Estimated time: 3–4 hours per screen group

Phase 4: Mobile Ordering & Receipts

OrderView.swift: menu selection, cart, checkout via GoodtillAPI.createExternalSale()

ReceiptsView.swift: list past orders and detailed receipt view

Integration with POS for order fulfillment

Phase 5: Analytics & Admin

Admin Portal:

Embed an Airtable‑synced backend for promotions and store config

In-app admin screens (staff clock‑in/out, sales summary)

Analytics:

Instrument events in the app, send to Firebase or Amplitude

Dashboard screens in-app or web

Architectural Notes

Keep all source files within LoyaltyApp/ Xcode target; avoid separate SPM targets to reduce complexity.

Use MockGoodtillAPI for local UI development; swap to real GoodtillAPI behind a feature flag.

Maintain at least 80% unit test coverage on business logic and 100% UI-test coverage on critical flows.

Leverage GitHub Actions to run both unit and UI tests on every push.

Last updated: 2025-06-13
