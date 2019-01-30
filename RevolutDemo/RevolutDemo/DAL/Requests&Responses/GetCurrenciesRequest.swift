//
//  GetAccountsRequest.swift
//  EquifyCRM
//
//  Created by Apple on 7/6/18.
//  Copyright © 2018 Maliwan. All rights reserved.
//

import UIKit

struct GetCurrenciesRequest: DDRequest {
    var baseCurrency: String
}

extension GetCurrenciesRequest: HTTPGetRequest {
    var urlQueryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "base", value: baseCurrency)]
    }
    
    var additionalHeaders: [String: String]? {
        return nil
        //return ["Authorization": "Bearer " +  Keychain.getSgaredInstance().accessToken()]
    }
    
    var relativePath: String {
        return "/latest"
    }
}
