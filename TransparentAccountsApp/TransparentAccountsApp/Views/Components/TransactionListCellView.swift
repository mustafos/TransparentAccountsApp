//
//  TransactionListCellView.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 08.07.2025.
//

import SwiftUI

struct TransactionListCellView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: transaction.iconName)
                .font(.title2)
                .foregroundColor(transaction.iconColor)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(transaction.formattedAmount)
                    .font(.headline)
                    .foregroundColor(transaction.iconColor)
                
                if let name = transaction.counterPartyName {
                    Text("From: \(name)")
                        .font(.subheadline)
                }
                
                if let info = transaction.remittanceInfo {
                    Text(info)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }.padding(.vertical, 6)
    }
}
