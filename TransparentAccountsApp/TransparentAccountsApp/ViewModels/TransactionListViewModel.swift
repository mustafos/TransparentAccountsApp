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
    @Published var alertMessage: String?
    
    private let service = CSASService()
    
    func loadTransactions(accountId: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            transactions = try await service.fetchTransactions(for: accountId)
        } catch {
            alertMessage = error.localizedDescription
            transactions = []
        }
    }
}
