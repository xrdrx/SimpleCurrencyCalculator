//
//  ExchangeRate.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 19.03.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

struct ExchangeRates: Codable {
    var rates: [String: ExchangeRate]
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
