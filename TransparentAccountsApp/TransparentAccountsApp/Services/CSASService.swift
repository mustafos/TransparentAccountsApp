//
//  CSASService.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

class CSASService {
    private let baseURL = Configurations.baseUrl
    private let apiKey = Configurations.apiKey
    
    func fetchAccounts(completion: @escaping ([TransparentAccount]) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-Key")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(AccountsResponse.self, from: data)
                print("✅ Decoded accounts:", decoded.accounts)
                completion(decoded.accounts)
            } catch {
                print("❌ Decode error:", error)
                print("📥 Raw:", String(data: data, encoding: .utf8) ?? "nil")
                completion([])
            }
        }.resume()
    }
    
    func fetchTransactions(for accountId: String, completion: @escaping ([Transaction]) -> Void) {
        let urlString = "\(baseURL)/\(accountId)/transactions"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-Key")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }

            struct ResponseWrapper: Decodable {
                let transactions: [Transaction]
            }

            do {
                let wrapper = try JSONDecoder().decode(ResponseWrapper.self, from: data)
                completion(wrapper.transactions)
            } catch {
                print("❌ Decode error:", error)
                print("📥 Raw:", String(data: data, encoding: .utf8) ?? "nil")
                completion([])
            }
        }.resume()
    }
}
