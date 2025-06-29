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
            if viewModel.isLoading {
                ProgressView("Loading Transactions...")
            } else if viewModel.transactions.isEmpty {
                Text("No transactions found.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                ForEach(viewModel.transactions) { transaction in
                    NavigationLink(destination: DetailView(transaction: transaction)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("💸 \(transaction.amount, specifier: "%.2f") \(transaction.currency ?? "")")
                                .font(.headline)
                            if let name = transaction.counterPartyName {
                                Text("From: \(name)").font(.subheadline)
                            }
                            if let info = transaction.remittanceInfo {
                                Text(info).font(.footnote).foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle(account.name)
        .onAppear {
            viewModel.loadTransactions(accountId: account.accountNumber)
        }
    }
}
