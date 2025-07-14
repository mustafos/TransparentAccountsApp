//
//  TransparentAccountsApp.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

@main
struct TransparentAccountsApp: App {
    @StateObject private var diContainer = DIContainer()
    @State private var viewModel: AccountListViewModel?
    
    var body: some Scene {
        WindowGroup {
            if let viewModel {
                AccountListView(viewModel: viewModel)
                    .environmentObject(diContainer)
            } else {
                ProgressView("Loading...")
                    .task {
                        viewModel = await diContainer.app.makeAccountListViewModel()
                    }
            }
        }
    }
}
