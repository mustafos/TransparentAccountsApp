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

    func loadTransactions(accountId: String) async {
        isLoading = true
        transactions = await service.fetchTransactions(for: accountId)
        isLoading = false
    }
}
