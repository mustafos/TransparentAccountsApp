//
//  TransactionDetailView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction
    
    var body: some View {
        Form {
            Section(header: Text("Amount")) {
                Text("\(transaction.amount, specifier: "%.2f") \(transaction.currency)")
            }
            
            if let counterParty = transaction.counterPartyName {
                Section(header: Text("Counterparty")) {
                    Text(counterParty)
                }
            }
            
            if let sender = transaction.senderName {
                Section(header: Text("Sender")) {
                    Text(sender)
                }
            }
            
            if let info = transaction.remittanceInfo {
                Section(header: Text("Remittance Info")) {
                    Text(info)
                }
            }
            
            if let spec = transaction.specification {
                Section(header: Text("Specification")) {
                    Text(spec)
                }
            }
            
            if let date = transaction.transactionDate {
                Section(header: Text("Transaction Date")) {
                    Text(date.formattedDate())
                }
            }
            
            if let date = transaction.processingDate {
                Section(header: Text("Processing Date")) {
                    Text(date.formattedDate())
                }
            }
        }.navigationTitle("Transaction Detail")
    }
}
