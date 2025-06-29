//
//  LaunchView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct LaunchView: View {
    @State private var isReady = false
    
    var body: some View {
        Group {
            if isReady {
                AccountListView()
            } else {
                ProgressView("Preparing...")
                    .task {
                        await AppState.shared.prepare()
                        isReady = true
                    }
            }
        }
    }
}


#Preview {
    LaunchView()
}
