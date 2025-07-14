//
//  TransparentAccountsAppApp.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

@main
struct TransparentAccountsAppApp: App {
    @StateObject private var diContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            AccountListView(viewModel: diContainer.app.makeAccountListViewModel())
                .environmentObject(diContainer)
        }
    }
}
