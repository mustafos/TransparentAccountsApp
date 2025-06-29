//
//  TransactionListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

@MainActor
class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false

    private let service = CSASService()

    func loadTransactions(accountId: String) {
        isLoading = true
        service.fetchTransactions(for: accountId) { [weak self] transactions in
            DispatchQueue.main.async {
                self?.transactions = transactions
                self?.isLoading = false
            }
        }
    }
}
