//
//  AppDIContainer.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 14.07.2025.
//

import Foundation

final class AppDIContainer {

    // MARK: - Singletons / Shared instances
    lazy var logger: LoggerProtocol = Logger()
    lazy var service: CSASServiceProtocol = CSASService(logger: logger)

    // MARK: - ViewModel Factories
    func makeAccountListViewModel() -> AccountListViewModel {
        AccountListViewModel(service: service, logger: logger)
    }

    func makeTransactionListViewModel() -> TransactionListViewModel {
        TransactionListViewModel(service: service, logger: logger)
    }
}
