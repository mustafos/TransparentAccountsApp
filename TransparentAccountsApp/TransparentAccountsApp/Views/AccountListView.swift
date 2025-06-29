//
//  AccountListView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct AccountListView: View {
    @StateObject private var viewModel = AccountListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Accounts...")
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if viewModel.accounts.isEmpty {
                    Text("No accounts found.")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    List(viewModel.accounts) { account in
                        NavigationLink(destination: TransactionListView(account: account)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(account.name)
                                    .font(.headline)
                                Text(account.accountNumber)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Text("💰 \(account.balance, specifier: "%.2f") \(account.currency ?? "")")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
        }
        .navigationTitle("Transparent Accounts")
        .onAppear {
            viewModel.loadAccounts()
        }

    }
}

#Preview {
    AccountListView()
}
