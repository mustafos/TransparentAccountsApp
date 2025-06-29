//
//  AppConfig.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

enum Secrets {
    static var csasApiKey: String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["CSAS_API_KEY"] as? String else {
            fatalError("❌ CSAS_API_KEY not found in Info.plist")
        }
        return key
    }
}

enum Configurations {
    static let accountId: String = "51930011-8925-4777-ba73-1dd422bb09c3"
    static let baseUrl: String = "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3/transparentAccounts"
}
