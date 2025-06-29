//
//  DetailView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct DetailView: View {
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

            if let info = transaction.remittanceInfo {
                Section(header: Text("Note")) {
                    Text(info)
                }
            }
        }
        .navigationTitle("Transaction Detail")
    }
}

