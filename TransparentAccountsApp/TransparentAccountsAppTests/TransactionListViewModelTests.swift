//
//  TransactionListViewModelTests.swift
//  TransparentAccountsAppTests
//
//  Created by Mustafa Bekirov on 08.07.2025.
//

import XCTest
@testable import TransparentAccountsApp

final class TransactionListViewModelTests: XCTestCase {
    
    // MARK: - Setup / Teardown
    
    override func setUpWithError() throws {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        print("🧪 Test starting...")
    }
    
    override func tearDownWithError() throws {
        print("✅ Test finished.")
        try super.tearDownWithError()
    }
    
    // MARK: - Initial State
    
    @MainActor
    func testInitialState() {
        let viewModel = TransactionListViewModel(service: MockCSASService(), logger: SilentLogger())
        XCTAssertEqual(viewModel.transactions.count, 0)
        XCTAssertEqual(viewModel.state, .idle)
    }
    
    // MARK: - Success Case
    
    @MainActor
    func testTransactionListViewModel_success() async {
        let mockService = MockCSASService()
        mockService.transactionsToReturn = [
            Transaction.mock(
                amount: 1500.0,
                currency: "CZK",
                processingDate: "2024-01-01",
                typeDescription: "Test",
                senderName: "Test Sender"
            )
        ]
        
        let viewModel = TransactionListViewModel(service: mockService, logger: SilentLogger())
        await viewModel.loadTransactions(accountId: "123456")
        
        XCTAssertEqual(viewModel.transactions.count, 1)
        XCTAssertEqual(viewModel.transactions.first?.senderName, "Test Sender")
        
        if case .success(let txs) = viewModel.state {
            XCTAssertEqual(txs.count, 1)
        } else {
            XCTFail("Expected success state")
        }
    }
    
    // MARK: - Error Handling
    
    @MainActor
    func testTransactionListViewModel_error() async {
        let mockService = MockCSASService()
        mockService.shouldFail = true
        
        let viewModel = TransactionListViewModel(service: mockService, logger: SilentLogger())
        await viewModel.loadTransactions(accountId: "123456")
        
        if case .error(let message) = viewModel.state {
            XCTAssertTrue(message.contains("Mock error"))
        } else {
            XCTFail("Expected error state")
        }
    }
    
    // MARK: - Empty State
    
    @MainActor
    func testTransactionListViewModel_emptyState() async {
        let mockService = MockCSASService()
        mockService.transactionsToReturn = []
        
        let viewModel = TransactionListViewModel(service: mockService, logger: SilentLogger())
        await viewModel.loadTransactions(accountId: "123456")
        
        XCTAssertTrue(viewModel.transactions.isEmpty)
        
        if case .empty = viewModel.state {
            // ✅ All good
        } else {
            XCTFail("Expected empty state")
        }
    }
    
    // MARK: - State Transition
    
    @MainActor
    func testTransactionListViewModel_stateTransition() async {
        let mockService = MockCSASService()
        mockService.transactionsToReturn = [
            Transaction.mock(amount: 100, currency: "CZK", processingDate: "2024-01-01")
        ]
        
        let viewModel = TransactionListViewModel(service: mockService, logger: SilentLogger())
        
        XCTAssertEqual(viewModel.state, .idle)
        await viewModel.loadTransactions(accountId: "123")
        XCTAssertEqual(viewModel.state, .success(mockService.transactionsToReturn))
    }
    
    // MARK: - JSON Decoding
    
    func testTransactionDecodingFromJSON() throws {
        let jsonData = try loadMockTransactionJSON()
        let transactions = try JSONDecoder().decode([Transaction].self, from: jsonData)
        XCTAssertEqual(transactions.count, 1)
        XCTAssertEqual(transactions.first?.remittanceInfo, "Test payment")
    }
    
    private func loadMockTransactionJSON() throws -> Data {
        guard let url = Bundle(for: type(of: self)).url(forResource: "MockTransactions", withExtension: "json") else {
            throw NSError(domain: "Missing file", code: 1, userInfo: nil)
        }
        return try Data(contentsOf: url)
    }
    
    // MARK: - Mocks
    
    class MockCSASService: CSASServiceProtocol {
        var transactionsToReturn: [Transaction] = []
        var shouldFail = false
        
        func fetchAccounts() async throws -> [TransparentAccount] {
            return []
        }
        
        func fetchTransactions(for accountId: String) async throws -> [Transaction] {
            if shouldFail {
                throw CSASError.httpError(code: 500, message: "Mock error")
            }
            return transactionsToReturn
        }
    }
    
    struct SilentLogger: LoggerProtocol {
        func log(_ event: LogEvent) { }
    }
}
