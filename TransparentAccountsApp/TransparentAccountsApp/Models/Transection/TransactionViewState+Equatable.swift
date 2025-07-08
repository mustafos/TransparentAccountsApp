//
//  TransactionViewState+Equatable.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 08.07.2025.
//

import Foundation

extension TransactionViewState: Equatable {
    public static func == (lhs: TransactionViewState, rhs: TransactionViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.empty, .empty):
            return true
        case (.error(let a), .error(let b)):
            return a == b
        case (.success(let a), .success(let b)):
            return a == b
        default:
            return false
        }
    }
}
