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
    
    private enum CodingKeys: String, CodingKey {
        case amount, processingDate, typeDescription, remittanceInfo,
             counterPartyName, transactionDate, specification, sender
    }
    
    private struct Amount: Decodable {
        let value: Double
        let currency: String
        
        private enum CodingKeys: String, CodingKey {
            case value, currency
        }
    }
    
    private struct Sender: Decodable {
        let name: String?
        
        private enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let amount = try container.decode(Amount.self, forKey: .amount)
        self.amount = amount.value
        self.currency = amount.currency
        
        self.processingDate = try container.decodeIfPresent(String.self, forKey: .processingDate)
        self.typeDescription = try container.decodeIfPresent(String.self, forKey: .typeDescription)
        self.remittanceInfo = try container.decodeIfPresent(String.self, forKey: .remittanceInfo)
        self.counterPartyName = try container.decodeIfPresent(String.self, forKey: .counterPartyName)
        self.transactionDate = try container.decodeIfPresent(String.self, forKey: .transactionDate)
        self.specification = try container.decodeIfPresent(String.self, forKey: .specification)
        
        let sender = try container.decodeIfPresent(Sender.self, forKey: .sender)
        self.senderName = sender?.name
    }
}
