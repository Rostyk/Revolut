//
//  DDEquifyAPI.swift
//  RevoluteDemo
//
//  Created by Ross Stepaniak on 6/25/18.
//  Copyright © 2018 Maliwan. All rights reserved.
//

import UIKit

class RevolutAPI: NSObject {
    private lazy var transport: DDRequestService? = {
        let baseUrlURL = "https://revolut.duckdns.org"
        let transport = DDRequestHTTPService(baseUrl: URL(string: baseUrlURL)!)
        return transport
    }()
    
    static let shared = RevolutAPI()
    private override init() { }
    
    public func getCurrencies(baseCurrency : String,
                            completion   : @escaping (GetCurrenciesResponse?, TransportError?) -> Void) {
        
        let getCurrenciesReqeust = GetCurrenciesRequest(baseCurrency: baseCurrency)
        
        transport?.send(request: getCurrenciesReqeust) {
            (response: GetCurrenciesResponse?, error: TransportError?) in
            if let response = response {
                if let _ = response.rates {
                    completion(response, nil)
                } else {
                    completion(nil, TransportError.DeserializationFailed)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    /*public func login(email      : String,
                      password   : String,
                      completion : @escaping (LoginResponse?, TransportError?) -> Void) {

        let loginRequest = LoginRequest(email    : email,
                                        password : password)
        
        transport?.send(request: loginRequest) {
            (response: LoginResponse?, error: TransportError?) in
            
            if let response = response {
                if let _ = response.jwtToken {
                    completion(response, nil)
                } else {
                    completion(nil, TransportError.DeserializationFailed)
                }
            } else {
                completion(nil, error)
            }
        }
    }*/
}
