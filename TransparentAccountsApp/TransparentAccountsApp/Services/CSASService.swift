//
//  CSASService.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

protocol CSASServiceProtocol {
    func fetchAccounts() async throws -> [TransparentAccount]
    func fetchTransactions(for accountId: String) async throws -> [Transaction]
}

enum CSASError: LocalizedError {
    case invalidURL
    case decodingError
    case httpError(code: Int, message: String?)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .decodingError:
            return "Failed to decode server response."
        case .httpError(let code, let message):
            return "HTTP \(code): \(message ?? "Unknown error")"
        case .unknown:
            return "Unknown error occurred."
        }
    }
}

final class CSASService: CSASServiceProtocol {
    private let baseURL = Configurations.baseUrl
    private let apiKey = Secrets.csasApiKey
    private let logger: LoggerProtocol
    
    init(logger: LoggerProtocol = Logger()) {
        self.logger = logger
    }
    
    private func fetch<T: Decodable>(_ path: String) async throws -> T {
        let fullPath = baseURL + path
        logger.log(.transactionDebug("🌐 Fetching: \(fullPath)"))
        
        guard let url = URL(string: fullPath) else {
            logger.log(.invalidURL(fullPath))
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
            logger.log(.transactionDebug("✅ Decoded response for path: \(path)"))
            return decoded
        } catch {
            if let csasError = error as? CSASError {
                logger.log(.unknownError(csasError.localizedDescription))
            } else {
                logger.log(.unknownError(error.localizedDescription))
            }
            throw error
        }
    }
    
    func fetchAccounts() async throws -> [TransparentAccount] {
        logger.log(.loadingAccounts)
        let response: AccountsResponse = try await fetch("")
        logger.log(.loadedAccounts(count: response.accounts.count))
        return response.accounts
    }
    
    func fetchTransactions(for accountId: String) async throws -> [Transaction] {
        let encodedId = accountId.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? accountId
        logger.log(.loadingTransactions(accountId: accountId))
        let response: TransactionsResponse = try await fetch("/\(encodedId)/transactions")
        logger.log(.loadedTransactions(accountId: accountId, count: response.transactions.count))
        if let first = response.transactions.first {
            logger.log(.transactionDebug("\(first)"))
        }
        return response.transactions
    }
    
    private func handleHTTPError(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.log(.unknownError("⚠️ Not an HTTP response"))
            throw CSASError.unknown
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            let message = parseErrorMessage(from: data)
            logger.log(.httpError(code: httpResponse.statusCode, message: message))
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