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
    @Published var alertMessage: String?
    
    private let service = CSASService()
    
    func loadAccounts() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            accounts = try await service.fetchAccounts()
        } catch {
            alertMessage = error.localizedDescription
            accounts = []
        }
    }
}
