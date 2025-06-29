//
//  TransactionListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

enum TransactionViewState {
    case idle, loading, success([Transaction]), empty, error(String)
}

@MainActor
final class TransactionListViewModel: ObservableObject {
    private let service: CSASServiceProtocol
    private let logger: LoggerProtocol
    
    @Published var transactions: [Transaction] = []
    @Published var state: TransactionViewState = .idle
    
    init(service: CSASServiceProtocol = CSASService(), logger: LoggerProtocol = Logger()) {
        self.service = service
        self.logger = logger
    }
    
    func loadTransactions(accountId: String) async {
        state = .loading
        logger.log(.loadingTransactions(accountId: accountId))
        
        do {
            let txs = try await service.fetchTransactions(for: accountId)
            transactions = txs
            if txs.isEmpty {
                state = .empty
            } else {
                state = .success(txs)
            }
        } catch {
            logger.log(.unknownError("❌ Error loading txs: \(error.localizedDescription)"))
            state = .error(error.localizedDescription)
        }
    }
}
