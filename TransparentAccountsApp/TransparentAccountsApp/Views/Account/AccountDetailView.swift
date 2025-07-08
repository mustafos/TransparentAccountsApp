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
            }.padding()
        }
        .navigationTitle("Account Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension AccountDetailView {
    var accountInfoSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            InfoRow("Account Number", value: account.accountNumber)
            InfoRow("Bank Code", value: account.bankCode)
            InfoRow("IBAN", value: account.iban)
            InfoRow("Balance", value: String(format: "%.2f %@", account.balance, account.currency ?? ""))
            InfoRow("Transparency From", value: account.transparencyFrom.formattedDate())
            InfoRow("Transparency To", value: account.transparencyTo.formattedDate())
            InfoRow("Publication To", value: account.publicationTo.formattedDate())
            InfoRow("Updated", value: account.actualizationDate.formattedDate())
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
}
