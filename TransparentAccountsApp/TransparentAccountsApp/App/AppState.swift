//
//  AppState.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

@MainActor
final class AppState {
    static let shared = AppState()

    private init() {}

    func prepare() async {
        // Here you can preload data, validate config, init analytics etc.
        try? await Task.sleep(nanoseconds: 500_000_000) // Simulate
        print("✅ App is ready")
    }
}
