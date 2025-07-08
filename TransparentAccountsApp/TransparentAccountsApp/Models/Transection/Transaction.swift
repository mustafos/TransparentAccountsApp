//
//  Transaction.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

struct Transaction: Decodable, Identifiable, Equatable {
    let id: UUID
    let amount: Double
    let currency: String
    let processingDate: String?
    let typeDescription: String?
    let senderName: String?
    let remittanceInfo: String?
    let counterPartyName: String?
    let transactionDate: String?
    let specification: String?
    
    // MARK: - Coding
    
    private enum CodingKeys: String, CodingKey {
        case amount, processingDate, typeDescription, remittanceInfo,
             counterPartyName, transactionDate, specification, sender
    }
    
    private struct Amount: Decodable {
        let value: Double
        let currency: String
    }
    
    private struct Sender: Decodable {
        let name: String?
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
        
        self.id = UUID()
    }
    
    // MARK: - Mock factory
    
    static func mock(
        amount: Double,
        currency: String,
        processingDate: String? = nil,
        typeDescription: String? = nil,
        senderName: String? = nil,
        remittanceInfo: String? = nil,
        counterPartyName: String? = nil,
        transactionDate: String? = nil,
        specification: String? = nil
    ) -> Transaction {
        return Transaction(
            id: UUID(),
            amount: amount,
            currency: currency,
            processingDate: processingDate,
            typeDescription: typeDescription,
            senderName: senderName,
            remittanceInfo: remittanceInfo,
            counterPartyName: counterPartyName,
            transactionDate: transactionDate,
            specification: specification
        )
    }
    
    // MARK: - Internal initializer (used in mock)
    
    private init(
        id: UUID = UUID(),
        amount: Double,
        currency: String,
        processingDate: String?,
        typeDescription: String?,
        senderName: String?,
        remittanceInfo: String?,
        counterPartyName: String?,
        transactionDate: String?,
        specification: String?
    ) {
        self.id = id
        self.amount = amount
        self.currency = currency
        self.processingDate = processingDate
        self.typeDescription = typeDescription
        self.senderName = senderName
        self.remittanceInfo = remittanceInfo
        self.counterPartyName = counterPartyName
        self.transactionDate = transactionDate
        self.specification = specification
    }
}
