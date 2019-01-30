//
//  RevolutDemoTests.swift
//  RevolutDemoTests
//
//  Created by Apple on 1/30/19.
//  Copyright © 2019 Ross Stepaniak. All rights reserved.
//

import XCTest

class RevolutCurrencyControllerTests: XCTestCase {
    private let currencyController = CurrencyController()
    private var currencyPingExpectation = XCTestExpectation()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCurrencyController() {
        currencyController.baseAmount = 1
        currencyController.baseCurrency = "EUR"
        currencyController.presentable = self
        currencyController.startCurrencyPoll()
       
        wait(for: [currencyPingExpectation], timeout: 3.0)
    }

}

extension RevolutCurrencyControllerTests: CurrencyPresentable {
    func refreshCurrencies() {
        currencyPingExpectation.fulfill()
    }
}
