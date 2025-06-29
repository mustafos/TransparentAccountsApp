//
//  TransactionListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation
import os

enum TransactionViewState {
    case idle, loading, success([Transaction]), empty, error(String)
}

@MainActor
final class TransactionListViewModel: ObservableObject {
    private let service: CSASServiceProtocol
    @Published var transactions: [Transaction] = []
    @Published var state: TransactionViewState = .idle
    
    init(service: CSASServiceProtocol = CSASService()) {
        self.service = service
    }
    
    func loadTransactions(accountId: String) async {
        state = .loading
        os_log("🔄 Loading for %{public}s", log: CSASLog.general, type: .info, accountId)
        
        do {
            let txs = try await service.fetchTransactions(for: accountId)
            transactions = txs
            if txs.isEmpty {
                state = .empty
            } else {
                state = .success(txs)
            }
        } catch {
            state = .error(error.localizedDescription)
            os_log("❌ Error loading txs: %@", log: CSASLog.general, type: .error, error.localizedDescription)
        }
    }
}
