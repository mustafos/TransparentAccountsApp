//
//  AccountDetailView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import SwiftUI

struct AccountDetailView: View {
    let account: TransparentAccount
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(account.name)
                    .font(.title2).bold()
                
                accountInfoSection
                
                NavigationLink("📄 View Transactions") {
                    TransactionListView(account: account)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Account Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var accountInfoSection: some View {
        Group {
            LabeledText("Account Number", value: account.accountNumber)
            LabeledText("Bank Code", value: account.bankCode)
            LabeledText("IBAN", value: account.iban)
            LabeledText("Balance", value: String(format: "%.2f %@", account.balance, account.currency ?? ""))
            LabeledText("Transparency From", value: account.transparencyFrom.formattedDate())
            LabeledText("Transparency To", value: account.transparencyTo.formattedDate())
            LabeledText("Publication To", value: account.publicationTo.formattedDate())
            LabeledText("Updated", value: account.actualizationDate.formattedDate())
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}

struct LabeledText: View {
    let label: String
    let value: String
    
    init(_ label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text("\(label):")
                .bold()
            Text(value)
        }
    }
}
