//
//  Transaction.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

struct Transaction: Decodable, Identifiable {
    let id = UUID()
    let amount: Double
    let currency: String
    let counterPartyName: String?
    let remittanceInfo: String?

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case currency = "currency"
        case counterPartyName = "counterPartyName"
        case remittanceInfo1
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        amount = try container.decode(Double.self, forKey: .amount)
        currency = try container.decode(String.self, forKey: .currency)
        counterPartyName = try container.decodeIfPresent(String.self, forKey: .counterPartyName)
        remittanceInfo = try container.decodeIfPresent(String.self, forKey: .remittanceInfo1)
    }
}
