//
//  DateFormatter+Extensions.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

extension String {
    func formattedDate(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss",
                           outputFormat: String = "dd.MM.yyyy HH:mm") -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "cs_CZ")

        guard let date = inputFormatter.date(from: self) else {
            return self
        }

        return outputFormatter.string(from: date)
    }
}
