//
//  GetAccountsResponse.swift
//  EquifyCRM
//
//  Created by Apple on 7/6/18.
//  Copyright © 2018 Maliwan. All rights reserved.
//

import Foundation

struct GetCurrenciesResponse: DDResponse {
    var rates: [String:Float]!
}

extension GetCurrenciesResponse: Deserializable {
    init?(data: Data) {
        guard let response = try? JSONDecoder().decode(GetCurrenciesResponse.self, from: data) else { return nil }
        
        rates = response.rates
    }
}
