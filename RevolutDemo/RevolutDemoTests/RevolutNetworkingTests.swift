//
//  RevolutDemoTests.swift
//  RevolutDemoTests
//
//  Created by Apple on 1/30/19.
//  Copyright © 2019 Ross Stepaniak. All rights reserved.
//

import XCTest

class RevolutNetworkingTests: XCTestCase {
    private var validCurrencyExpectation = XCTestExpectation()
    private var incorrectCurrencyExpectation = XCTestExpectation()
    private let currencies:[String] = ["EUR", "PLN", "XXX"]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessCurrencyAPI() {
        RevolutAPI.shared.getCurrencies(baseCurrency: currencies[0]) { [weak self](response, error) in
            self?.validCurrencyExpectation.fulfill()
            
            XCTAssertNil(error, "Could not complete request")
            XCTAssertNotNil(response, "Could not get proper response")
            
            if let response = response {
                XCTAssert(response.rates.count > 0, "Could not get any currency rates")
                
                if let rate = response.rates.first {
                    let (code, value) = rate
                    
                    XCTAssert(code.count > 0, "Currency code should be a valid string")
                    XCTAssert(value > 0, "Currency exchange rate should be a valid number")
                }
            }
        }
        
        wait(for: [validCurrencyExpectation], timeout: 4.0)
    }
    
    func testFailureCurrencyAPI() {
        RevolutAPI.shared.getCurrencies(baseCurrency: currencies[2]) { [weak self](response, error) in
            self?.incorrectCurrencyExpectation.fulfill()
            
            XCTAssertNotNil(error, "Error should carry some information. Should not be nil")
            XCTAssert(error?.code == 423, "Status should be: Unprocessible entity")
            XCTAssertNil(response, "Could should be nil as the base is incorrect")
            
        }
        
        wait(for: [incorrectCurrencyExpectation], timeout: 4.0)
    }
}
