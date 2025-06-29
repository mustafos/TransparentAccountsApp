# 🏦 FinCheck – Transparent Accounts Viewer

**FinCheck** is a SwiftUI-based iOS app for browsing publicly available transparent bank accounts and their transactions using the official ČSAS public API.

## 📱 Features

- 🔍 Browse a list of transparent accounts with name, number, balance, and currency
- 📋 View detailed account information including IBAN, bank code, transparency periods, and last update
- 💸 Explore transaction history with icons, amount direction (positive/negative), and metadata
- 🔎 Transaction detail screen with sender, counterparty, remittance info, and dates
- 🔄 Pull-to-refresh and automatic data loading
- ⚠️ Error handling for network issues and decoding errors
- 🧩 Logging with `os_log` categorized by Network, Decoding, and General

## ⚙️ Tech Stack

- iOS 18.5
- SwiftUI (MVVM)
- `URLSession` for networking
- `os_log` for structured logging

## 🚀 Getting Started

1. Clone this repository
2. Open `TransparentAccountsApp.xcodeproj` in Xcode 15+
3. Update `Configurations.swift` with your API key:

```swift
enum Configurations {
    static let baseUrl = "https://www.csas.cz/webapi/api/v1/transparentAccounts"
    static let apiKey = "<your-public-api-key>"
}
```

4. Build and run on a simulator or device

## 🔐 API Info

Data is fetched from the official ČSAS Transparent Accounts API:  
🔗 [https://developers.csas.cz/portal/product/transparent-accounts-v1](https://developers.csas.cz/portal/product/transparent-accounts-v1)

The API allows:
- Fetching a list of transparent accounts
- Fetching transactions by account number

## 🧪 Preview

![FinCheck App](https://github.com/mustafos/mustafos/blob/master/assets/fincheck.gif)

## 📁 Project Structure

```
TransparentAccountsApp
├── Models/
│   ├── TransparentAccount.swift
│   └── Transaction.swift
├── Views/
│   ├── AccountListView.swift
│   ├── AccountDetailView.swift
│   ├── TransactionListView.swift
│   └── DetailView.swift
├── ViewModels/
│   ├── AccountListViewModel.swift
│   └── TransactionListViewModel.swift
├── Services/
│   └── CSASService.swift
├── Utils/
│   ├── AppConfig.swift
│   ├── CSASLog.swift
│   └── DateFormatter+Extensions.swift
└── TransparentAccountsAppApp.swift
```

## 🧹 To Do

- Add search functionality by account name or number
- Support dark mode
- Add unit tests for `CSASService`

---

© 2025 Mustafa Bekirov
