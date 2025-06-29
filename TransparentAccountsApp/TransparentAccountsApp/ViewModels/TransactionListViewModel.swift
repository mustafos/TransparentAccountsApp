//
//  TransactionListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation
import os

@MainActor
class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false
    @Published var alertMessage: String?
    
    private let service = CSASService()
    
    func loadTransactions(accountId: String) async {
        isLoading = true
        os_log("🔄 Start loading transactions for %{public}s", log: CSASLog.general, type: .info, accountId)
        transactions = []
        defer {
            isLoading = false
            os_log("✅ Finished loading transactions for %{public}s", log: CSASLog.general, type: .info, accountId)
        }
        
        do {
            transactions = try await service.fetchTransactions(for: accountId)
        } catch {
            alertMessage = error.localizedDescription
            transactions = []
            os_log("❌ Failed to load transactions: %@", log: CSASLog.general, type: .error, error.localizedDescription)
        }
    }
}
