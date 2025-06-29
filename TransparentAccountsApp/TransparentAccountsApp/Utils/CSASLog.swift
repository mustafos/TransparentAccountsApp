//
//  CSASLog.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation
import os

enum CSASLog {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "FinCheck"
    
    static let network = OSLog(subsystem: subsystem, category: "🌐 Network")
    static let decoding = OSLog(subsystem: subsystem, category: "🧩 Decoding")
    static let general  = OSLog(subsystem: subsystem, category: "📋 General")
}
