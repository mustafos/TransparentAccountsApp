//
//  TransparentAccount.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

struct TransparentAccount: Decodable, Identifiable {
    var id: String { accountNumber }
    let accountNumber: String
    let bankCode: String
    let transparencyFrom: String
    let transparencyTo: String
    let publicationTo: String
    let actualizationDate: String
    let balance: Double
    let currency: String?
    let name: String
    let iban: String
}
