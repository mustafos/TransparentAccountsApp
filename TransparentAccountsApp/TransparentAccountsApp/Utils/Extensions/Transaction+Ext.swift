//
//  Transaction+Ext.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 08.07.2025.
//

import SwiftUI

extension Transaction {
    var isIncome: Bool {
        amount >= 0
    }

    var iconName: String {
        isIncome ? "arrow.up.circle.fill" : "arrow.down.circle.fill"
    }

    var iconColor: Color {
        isIncome ? .green : .red
    }

    var formattedAmount: String {
        String(format: "%.2f %@", amount, currency)
    }
}
