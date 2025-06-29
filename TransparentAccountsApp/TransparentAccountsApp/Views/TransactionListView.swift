//
//  TransactionListView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct TransactionListView: View {
    let account: TransparentAccount
    @StateObject private var viewModel = TransactionListViewModel()
    
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
                    NavigationLink(destination: DetailView(transaction: transaction)) {
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


// MARK: - Transaction Cell
struct TransactionListCellView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: transaction.amount >= 0 ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                .font(.title2)
                .foregroundColor(transaction.amount >= 0 ? .green : .red)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(transaction.amount, specifier: "%.2f") \(transaction.currency)")
                    .font(.headline)
                    .foregroundColor(transaction.amount >= 0 ? .green : .red)
                
                if let name = transaction.counterPartyName {
                    Text("From: \(name)").font(.subheadline)
                }
                
                if let info = transaction.remittanceInfo {
                    Text(info).font(.footnote).foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 6)
    }
}
