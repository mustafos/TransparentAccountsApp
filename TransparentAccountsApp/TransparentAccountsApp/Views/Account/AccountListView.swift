//
//  AccountListView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct AccountListView: View {
    @StateObject var viewModel: AccountListViewModel
    @EnvironmentObject var diContainer: DIContainer
    
    init(viewModel: AccountListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Loading...")
                case .success:
                    List(viewModel.accounts) { account in
                        NavigationLink(destination: AccountDetailView(account: account)) {
                            Text(account.name)
                        }
                    }
                case .error(let message):
                    Text("❌ \(message)")
                        .foregroundColor(.red)
                }
            }.navigationTitle("Transparent Accounts")
        }
        .task {
            await viewModel.loadAccounts()
        }
    }
}

#Preview {
    AccountListView(viewModel: AppDIContainer().makeAccountListViewModel())
}
