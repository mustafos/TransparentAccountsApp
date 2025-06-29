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

    func loadAccounts() async {
        isLoading = true
        accounts = await service.fetchAccounts()
        isLoading = false
    }
}
