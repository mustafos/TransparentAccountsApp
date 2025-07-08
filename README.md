# 🏦 FinCheck – Transparent Accounts Viewer

**FinCheck** is a SwiftUI-based iOS app for browsing publicly available transparent bank accounts and their transactions using the official ČSAS public API.

---

## 📱 Features

- 🔍 Browse a list of transparent accounts
- 📋 View detailed account info: IBAN, bank code, balance, transparency periods
- 💸 Explore transactions with direction, sender, counterparty, and description
- 🔄 Pull-to-refresh and loading states
- ⚠️ Error messages on failure (network/decoding)
- 🧩 Logging with `os_log`

---

## ⚙️ Tech Stack

- iOS 18.5
- SwiftUI + MVVM
- `URLSession` for networking
- `.xcconfig`-based secret management
- `os_log` for logging

---

## 🚀 Getting Started

1. Clone this repository:
```bash
git clone https://github.com/mustafos/TransparentAccountsApp.git
```

2. Open `TransparentAccountsApp.xcodeproj` in Xcode 15+

3. Set up the API key:

- Create a file `Secrets.xcconfig` at the root of the project:
```sh
touch Secrets.xcconfig
```
- Add the following content:
```xcconfig
CSAS_API_KEY = your-public-api-key
```

- Example template:
```xcconfig
# Secrets.xcconfig.example
CSAS_API_KEY = <# Insert your CSAS API key here #>
```

- Ensure `Info.plist` (already included) contains:
```xml
<key>CSAS_API_KEY</key>
<string>$(CSAS_API_KEY)</string>
```
> 💡 `Secrets.xcconfig.example` is included as a reference.  
> Do **not** commit your actual `Secrets.xcconfig` — it's gitignored for security.

4. Build and run the app.

---

## 🔐 API Info

Data is fetched from the official ČSAS Transparent Accounts API:  
🔗 [ERSTE Group](https://developers.csas.cz/portal/product/transparent-accounts-v1)

---

## 🧪 Preview

![FinCheck App](https://github.com/mustafos/mustafos/blob/master/assets/fincheck.gif)

---

## 📁 Project Structure

```
TransparentAccountsApp
├── Models/
│   ├── Transaction/
│   │   ├── Transaction.swift
│   │   └── Transaction+Equatable.swift
│   └── Account.swift
├── Services/
│   └── CSASService.swift
├── ViewModels/
│   ├── AccountListViewModel.swift
│   └── TransactionListViewModel.swift
├── Views/
│   ├── Account/
│   │   ├── AccountListView.swift
│   │   └── AccountDetailView.swift
│   ├── Transaction/
│   │   ├── TransactionListView.swift
│   │   └── TransactionDetailView.swift
│   └── Components/
│       ├── InfoRow.swift
│       └── TransactionListCellView.swift
├── Utils/
│   ├── CSASLog.swift
│   ├── Secrets.swift
│   └── Extensions/
│       ├── Date+Ext.swift
│       └── Transaction+Ext.swift
├── Assets.xcassets
├── Info.plist
├── Secrets.xcconfig
├── TransparentAccountsAppApp.swift
└── TransparentAccountsAppTests/
├── MockTransactions.json
└── TransactionListViewModelTests.swift
```

---

## ✅ To Do

- [ ] Add search bar to filter accounts
- [ ] Support Dark Mode
- [x] Add unit tests for `CSASService`
- [x] Refactor config/secret management via `.xcconfig`

---

© 2025 Mustafa Bekirov
