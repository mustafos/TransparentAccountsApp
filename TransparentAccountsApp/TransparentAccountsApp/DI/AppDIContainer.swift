//
//  AppDIContainer.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 14.07.2025.
//

import Foundation

final class DIContainer: ObservableObject {
    let app: AppDIContainer
    
    init(app: AppDIContainer = AppDIContainer()) {
        self.app = app
    }
}

final class AppDIContainer {
    // Shared dependencies
    lazy var logger: LoggerProtocol = Logger()
    lazy var service: CSASServiceProtocol = CSASService(logger: logger)
    
    // ViewModel factories
    func makeAccountListViewModel() async -> AccountListViewModel {
        await AccountListViewModel(service: service, logger: logger)
    }

    func makeTransactionListViewModel() async -> TransactionListViewModel {
        await TransactionListViewModel(service: service, logger: logger)
    }
}
