//
//  Date+Ext.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

extension DateFormatter {
    static let iso8601Input: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    static let czechDisplay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.locale = Locale(identifier: "cs_CZ")
        return formatter
    }()
}

extension String {
    func formattedDate() -> String {
        guard let date = DateFormatter.iso8601Input.date(from: self) else {
            return self
        }
        return DateFormatter.czechDisplay.string(from: date)
    }
}
