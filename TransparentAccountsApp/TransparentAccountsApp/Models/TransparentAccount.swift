//
//  TransparentAccount.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

struct TransparentAccount: Decodable, Identifiable {
    let id: String
    let name: String
    let accountNumber: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "description"
        case accountNumber = "accountNumber"
    }
}
