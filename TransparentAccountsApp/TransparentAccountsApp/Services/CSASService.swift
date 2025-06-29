//
//  CSASService.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

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
        guard let url = URL(string: baseURL + path) else {
            throw CSASError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-Key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try handleHTTPError(data: data, response: response)
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CSASError.decodingError
        }
    }
    
    /// Load accounts
    func fetchAccounts() async throws -> [TransparentAccount] {
        let response: AccountsResponse = try await fetch("")
        return response.accounts
    }
    
    /// Load transactions for account
    func fetchTransactions(for accountId: String) async throws -> [Transaction] {
        let response: TransactionsResponse = try await fetch("/\(accountId)/transactions")
        return response.transactions
    }
    
    /// Error handling
    private func handleHTTPError(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CSASError.unknown
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            let message = parseErrorMessage(from: data)
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
