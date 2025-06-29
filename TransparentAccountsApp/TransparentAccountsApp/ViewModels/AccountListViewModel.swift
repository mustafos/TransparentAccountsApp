//
//  AccountListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

enum ViewState {
    case idle, loading, success, error(String)
}

@MainActor
final class AccountListViewModel: ObservableObject {
    private let service: CSASServiceProtocol
    private let logger: LoggerProtocol
    
    @Published var accounts: [TransparentAccount] = []
    @Published var state: ViewState = .idle
    
    init(service: CSASServiceProtocol = CSASService(), logger: LoggerProtocol = Logger()) {
        self.service = service
        self.logger = logger
    }
    
    func loadAccounts() async {
        state = .loading
        logger.log(.transactionDebug("📥 Loading accounts..."))
        do {
            accounts = try await service.fetchAccounts()
            state = .success
        } catch {
            logger.log(.unknownError("❌ Account load error: \(error.localizedDescription)"))
            state = .error(error.localizedDescription)
        }
    }
}
