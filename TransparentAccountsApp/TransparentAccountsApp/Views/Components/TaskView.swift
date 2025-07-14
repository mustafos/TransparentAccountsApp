//
//  TaskView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 14.07.2025.
//

import SwiftUI

/// A wrapper view that executes asynchronous content and renders it once available.
struct TaskView<Content: View>: View {
    @ViewBuilder let contentBuilder: () async throws -> Content
    
    @State private var loadedView: Content?
    @State private var error: Error?
    
    var body: some View {
        Group {
            if let loadedView {
                loadedView
            } else if let error {
                Text("❌ \(error.localizedDescription)")
                    .foregroundColor(.red)
            } else {
                ProgressView("Loading…")
            }
        }
        .task {
            do {
                loadedView = try await contentBuilder()
            } catch {
                self.error = error
            }
        }
    }
}
