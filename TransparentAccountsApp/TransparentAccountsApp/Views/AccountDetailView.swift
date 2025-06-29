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
        VStack(alignment: .leading, spacing: 12) {
            Text(account.name).font(.title2).bold()
            Group {
                Text("Account Number: \(account.accountNumber)")
                Text("Bank Code: \(account.bankCode)")
                Text("IBAN: \(account.iban)")
                Text("Balance: \(account.balance, specifier: "%.2f") \(account.currency ?? "")")
                Text("Transparency From: \(account.transparencyFrom.formattedDate())")
                Text("Transparency To: \(account.transparencyTo.formattedDate())")
                Text("Publication To: \(account.publicationTo.formattedDate())")
                Text("Updated: \(account.actualizationDate.formattedDate())")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            NavigationLink("📄 View Transactions") {
                TransactionListView(account: account)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Account Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
