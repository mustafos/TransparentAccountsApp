//
//  CSASService.swift
//  TransparentAccountsApp
//
//  Created by Mustafa Bekirov on 29.06.2025.
//

import Foundation

class CSASService {
    private let baseURL = Configurations.baseUrl
    
    func fetchAccounts(completion: @escaping ([TransparentAccount]) -> Void) {
        guard let url = URL(string: baseURL) else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }

            if let accounts = try? JSONDecoder().decode([TransparentAccount].self, from: data) {
                print("✅ Loaded accounts:", accounts)
                completion(accounts)
            } else {
                print("❌ Failed to decode accounts")
                completion([])
            }
        }.resume()
    }

    func fetchTransactions(for accountId: String, completion: @escaping ([Transaction]) -> Void) {
        let urlString = "\(baseURL)/\(accountId)/transactions"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion([])
                return
            }

            struct Wrapper: Decodable {
                let transactions: [Transaction]
            }

            if let wrapper = try? JSONDecoder().decode(Wrapper.self, from: data) {
                completion(wrapper.transactions)
            } else {
                completion([])
            }
        }.resume()
    }
}
