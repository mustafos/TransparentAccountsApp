//
//  Secrets.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 09.07.2025.
//

import Foundation

enum Secrets {
    static var csasApiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "CSAS_API_KEY") as? String else {
            assertionFailure("❌ CSAS_API_KEY not set")
            return ""
        }
        return key
    }
}
