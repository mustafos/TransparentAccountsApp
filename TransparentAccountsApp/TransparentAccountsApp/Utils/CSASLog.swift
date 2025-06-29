//
//  CSASLog.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation
import os

// MARK: - Log Categories
enum LogCategory: String {
    case network = "🌐 Network"
    case decoding = "🧩 Decoding"
    case general  = "📋 General"
    
    var osLog: OSLog {
        OSLog(subsystem: Bundle.main.bundleIdentifier ?? "FinCheck", category: rawValue)
    }
}

// MARK: - Log Events
enum LogEvent {
    case loadingAccounts
    case loadedAccounts(count: Int)
    case loadingTransactions(accountId: String)
    case loadedTransactions(accountId: String, count: Int)
    case transactionDebug(String)
    case invalidURL(String)
    case decodingError(String)
    case httpError(code: Int, message: String?)
    case unknownError(String)
    
    var message: String {
        switch self {
        case .loadingAccounts:
            return "📥 Loading accounts..."
        case .loadedAccounts(let count):
            return "📦 Loaded \(count) accounts"
        case .loadingTransactions(let id):
            return "📥 Loading transactions for \(id)..."
        case .loadedTransactions(let id, let count):
            return "📦 Loaded \(count) transactions for \(id)"
        case .transactionDebug(let text):
            return text
        case .invalidURL(let url):
            return "🚫 Invalid URL: \(url)"
        case .decodingError(let desc):
            return "❌ Decoding error: \(desc)"
        case .httpError(let code, let message):
            return "❗️HTTP \(code): \(message ?? "Unknown")"
        case .unknownError(let desc):
            return "❌ Unknown error: \(desc)"
        }
    }
    
    var category: LogCategory {
        switch self {
        case .loadingAccounts, .loadingTransactions, .loadedTransactions, .loadedAccounts:
            return .network
        case .transactionDebug, .decodingError:
            return .decoding
        default:
            return .general
        }
    }
    
    var type: OSLogType {
        switch self {
        case .httpError, .invalidURL, .decodingError, .unknownError:
            return .error
        case .transactionDebug:
            return .debug
        default:
            return .info
        }
    }
}

// MARK: - Protocol
protocol LoggerProtocol {
    func log(_ event: LogEvent)
}

// MARK: - Default Logger
final class Logger: LoggerProtocol {
    func log(_ event: LogEvent) {
        os_log("%@", log: event.category.osLog, type: event.type, event.message)
    }
}
