//
//  CSASService.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

final class CSASService {
    private let baseURL = Configurations.baseUrl
    private let apiKey = Configurations.apiKey

    func fetchAccounts() async throws -> [TransparentAccount] {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-Key")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(AccountsResponse.self, from: data)
        return decoded.accounts
    }

    func fetchTransactions(for accountId: String) async throws -> [Transaction] {
        guard let url = URL(string: "\(baseURL)/\(accountId)/transactions") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-Key")

        let (data, _) = try await URLSession.shared.data(for: request)
        let wrapper = try JSONDecoder().decode(ResponseWrapper.self, from: data)
        return wrapper.transactions
    }

    private struct ResponseWrapper: Decodable {
        let transactions: [Transaction]
    }
}
