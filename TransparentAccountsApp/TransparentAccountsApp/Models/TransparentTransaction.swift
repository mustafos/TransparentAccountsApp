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
    let processingDate: String?
    let typeDescription: String?
    let senderName: String?
    let remittanceInfo: String?
    let counterPartyName: String?
    let transactionDate: String?
    let specification: String?

    enum CodingKeys: String, CodingKey {
        case amount, processingDate, typeDescription, remittanceInfo, counterPartyName, transactionDate, specification
        case sender
    }

    enum AmountKeys: String, CodingKey {
        case value, currency
    }

    enum SenderKeys: String, CodingKey {
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let amountContainer = try container.nestedContainer(keyedBy: AmountKeys.self, forKey: .amount)
        amount = try amountContainer.decode(Double.self, forKey: .value)
        currency = try amountContainer.decode(String.self, forKey: .currency)

        processingDate = try container.decodeIfPresent(String.self, forKey: .processingDate)
        typeDescription = try container.decodeIfPresent(String.self, forKey: .typeDescription)
        remittanceInfo = try container.decodeIfPresent(String.self, forKey: .remittanceInfo)
        counterPartyName = try container.decodeIfPresent(String.self, forKey: .counterPartyName)
        transactionDate = try container.decodeIfPresent(String.self, forKey: .transactionDate)
        specification = try container.decodeIfPresent(String.self, forKey: .specification)

        if let senderContainer = try? container.nestedContainer(keyedBy: SenderKeys.self, forKey: .sender) {
            senderName = try senderContainer.decodeIfPresent(String.self, forKey: .name)
        } else {
            senderName = nil
        }
    }
}
