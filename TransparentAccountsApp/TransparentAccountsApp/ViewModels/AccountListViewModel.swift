//
//  AccountListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

@MainActor
class AccountListViewModel: ObservableObject {
    @Published var accounts: [TransparentAccount] = []
    @Published var isLoading = false

    private let service = CSASService()

    func loadAccounts() {
        isLoading = true
        service.fetchAccounts { [weak self] accounts in
            DispatchQueue.main.async {
                self?.accounts = accounts
                self?.isLoading = false
            }
        }
    }
}
