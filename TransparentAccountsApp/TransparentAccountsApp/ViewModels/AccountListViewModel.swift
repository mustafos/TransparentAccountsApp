//
//  AccountListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation
import os

@MainActor
class AccountListViewModel: ObservableObject {
    @Published var accounts: [TransparentAccount] = []
    @Published var isLoading = false
    @Published var alertMessage: String?
    
    private let service = CSASService()
    
    func loadAccounts() async {
        isLoading = true
        os_log("🔄 Start loading accounts", log: CSASLog.general, type: .info)
        defer {
            isLoading = false
            os_log("✅ Finished loading accounts", log: CSASLog.general, type: .info)
        }
        
        do {
            accounts = try await service.fetchAccounts()
        } catch {
            alertMessage = error.localizedDescription
            accounts = []
            os_log("❌ Failed to load accounts: %@", log: CSASLog.general, type: .error, error.localizedDescription)
        }
    }
}
