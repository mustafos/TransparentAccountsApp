//
//  AccountListViewModel.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation
import os

enum ViewState {
    case idle, loading, success, error(String)
}

@MainActor
final class AccountListViewModel: ObservableObject {
    private let service: CSASServiceProtocol
    @Published var accounts: [TransparentAccount] = []
    @Published var state: ViewState = .idle
    
    init(service: CSASServiceProtocol = CSASService()) {
        self.service = service
    }

    func loadAccounts() async {
        state = .loading
        do {
            accounts = try await service.fetchAccounts()
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
