//
//  InfoRow.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 08.07.2025.
//

import SwiftUI

struct InfoRow: View {
    private let label: String
    private let value: String
    
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
