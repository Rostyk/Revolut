//
//  CurrencyController.swift
//  RevolutDemo
//
//  Created by Apple on 1/29/19.
//  Copyright © 2019 Ross Stepaniak. All rights reserved.
//

import Foundation

protocol CurrencyPresentable: NSObjectProtocol {
    func refreshCurrencies()
}

class CurrencyController: NSObject {
    private var currencies = [Currency]()
    
    private var timer: Timer?
    public var baseCurrency: String = "EUR"
    public var baseAmount: Float = 1.0
    
    weak var presentable: CurrencyPresentable?
    
    func startCurrencyPoll() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerTick), userInfo: nil, repeats: true)
    }
    
    func stopCurrencyPoll() {
        timer?.invalidate()
    }
    
    func getCurrency(_ index: Int) -> Currency {
        return currencies[index]
    }
    
    func numerOfCurrencies() -> Int {
        return currencies.count
    }
    
    @objc private func onTimerTick() {
        RevolutAPI.shared.getCurrencies(baseCurrency: baseCurrency) { [weak self] (response, error) in
            if let response = response {
                self?.currencies.removeAll()
                
                for (key, rate) in response.rates {
                    self?.currencies.append(Currency(code: key, value: rate * (self?.baseAmount)!))
                }
                
                self?.presentable?.refreshCurrencies()
            }
        }
    }
}
