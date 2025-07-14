//
//  TransparentAccountsAppApp.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

@main
struct TransparentAccountsAppApp: App {
    private let diContainer = AppDIContainer()
    var body: some Scene {
        WindowGroup {
//            AccountListView()
            AccountListView(viewModel: diContainer.makeAccountListViewModel())
        }
    }
}
