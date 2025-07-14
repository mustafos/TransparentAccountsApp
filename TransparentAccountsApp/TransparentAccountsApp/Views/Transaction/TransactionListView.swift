//
//  TransactionListView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct TransactionListView: View {
    
    let account: TransparentAccount
    @StateObject private var viewModel: TransactionListViewModel
    
    init(account: TransparentAccount, viewModel: TransactionListViewModel) {
        self.account = account
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Loading Transactions...")
                
            case .empty:
                Text("No transactions found.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            case .success(let transactions):
                ForEach(transactions) { transaction in
                    NavigationLink(destination: TransactionDetailView(transaction: transaction)) {
                        TransactionListCellView(transaction: transaction)
                    }
                }
                
            case .error(let message):
                Text("❌ \(message)")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if case .success = viewModel.state { return }
            await viewModel.loadTransactions(accountId: account.accountNumber)
        }
        .refreshable {
            await viewModel.loadTransactions(accountId: account.accountNumber)
        }
    }
}
