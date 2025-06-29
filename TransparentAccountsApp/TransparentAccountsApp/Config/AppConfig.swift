//
//  AppConfig.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

enum Configurations {
    // MARK: App Basic Info
    static let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Unknown App Name"
    static let appToken: String = "some token"
}
