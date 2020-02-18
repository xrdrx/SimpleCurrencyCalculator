//
//  CurrencyRates.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

struct ExchangeRates: Codable {
    var rates: [String: ExchangeRate]
}

enum Currency: String, CaseIterable {
    case AUD, BGN, BRL, CAD, CHF, CNY, CZK, DKK, EUR, GBP, HKD, HRK, HUF, IDR, ILS, INR, ISK, JPY, KRW, MXN, MYR, NOK, NZD, PHP, PLN, RON, RUB, SEK, SGD, THB, TRY, USD, ZAR
}

struct ExchangeRate: Codable {
    var rates: [String: Double]
    var base: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case rates
        case base
        case date
    }
}
    

