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
                } else {
                    List(viewModel.accounts) { account in
                        NavigationLink(destination: TransactionListView(account: account)) {
                            VStack(alignment: .leading) {
                                Text(account.name)
                                    .font(.headline)
                                Text(account.accountNumber)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Transparent Accounts")
            .onAppear { viewModel.loadAccounts() }
        }
    }
}

#Preview {
    AccountListView()
}
