//
//  CSASService.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation
import os

enum CSASError: LocalizedError {
    case invalidURL
    case decodingError
    case httpError(code: Int, message: String?)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "❌ Invalid URL."
        case .decodingError:
            return "❌ Failed to decode server response."
        case .httpError(let code, let message):
            return "❌ HTTP \(code): \(message ?? "Unknown error")"
        case .unknown:
            return "❌ Unknown error occurred."
        }
    }
}

final class CSASService {
    private let baseURL = Configurations.baseUrl
    private let apiKey = Configurations.apiKey
    
    /// Generic method to fetch and decode any Decodable response
    private func fetch<T: Decodable>(_ path: String) async throws -> T {
        let fullPath = baseURL + path
        os_log("🌐 Fetching: %@", log: CSASLog.network, type: .debug, fullPath)
        
        guard let url = URL(string: fullPath) else {
            os_log("🚫 Invalid URL: %@", log: CSASLog.network, type: .error, fullPath)
            throw CSASError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-Key")
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            try handleHTTPError(data: data, response: response)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            os_log("✅ Decoded response for path: %@", log: CSASLog.decoding, type: .info, path)
            return decoded
        } catch {
            if let csasError = error as? CSASError {
                os_log("❌ CSAS error: %@", log: CSASLog.general, type: .error, csasError.localizedDescription)
            } else {
                os_log("❌ Unexpected error: %@", log: CSASLog.general, type: .error, error.localizedDescription)
            }
            throw error
        }
    }
    
    /// Load accounts
    func fetchAccounts() async throws -> [TransparentAccount] {
        os_log("📥 Loading accounts...", log: CSASLog.general, type: .info)
        let response: AccountsResponse = try await fetch("")
        os_log("📦 Loaded %d accounts", log: CSASLog.general, type: .info, response.accounts.count)
        return response.accounts
    }
    
    /// Load transactions for account
    func fetchTransactions(for accountId: String) async throws -> [Transaction] {
        let encodedId = accountId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? accountId
        os_log("📥 Loading transactions for %{public}s...", log: CSASLog.general, type: .info, accountId)
        let response: TransactionsResponse = try await fetch("/\(encodedId)/transactions")
        os_log("📦 Loaded %d transactions for %{public}s", log: CSASLog.general, type: .info, response.transactions.count, accountId)
        if let first = response.transactions.first {
            os_log("📌 First transaction: %@", log: CSASLog.general, type: .debug, "\(first)")
        }
        return response.transactions
    }
    
    /// Error handling
    private func handleHTTPError(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            os_log("⚠️ Not an HTTP response", log: CSASLog.network, type: .error)
            throw CSASError.unknown
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            let message = parseErrorMessage(from: data)
            os_log("❗️HTTP %d: %@", log: CSASLog.network, type: .error, httpResponse.statusCode, message ?? "No message")
            throw CSASError.httpError(code: httpResponse.statusCode, message: message)
        }
    }
    
    private func parseErrorMessage(from data: Data) -> String? {
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let errors = json["errors"] as? [[String: Any]],
           let first = errors.first,
           let message = first["error"] as? String {
            return message
        }
        return nil
    }
    
    private struct AccountsResponse: Decodable {
        let accounts: [TransparentAccount]
    }
    
    private struct TransactionsResponse: Decodable {
        let transactions: [Transaction]
    }
}
