//
//  CurrencyRates.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

struct ExchangeRate: Codable {
    var rates: [String: Double]
    var base: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case rates
        case base
        case date
    }
    
    static var exchangeRates: [String: ExchangeRate] = [:]
    
    static let currencies: [String] = ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "ISK", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "THB", "TRY", "USD", "ZAR"]
    
    static let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let menuItemsFileUrl = documentsDirectoryURL.appendingPathComponent("exchangeRates").appendingPathExtension("json")
    
    static func loadRates() {
        guard let data = try? Data(contentsOf: menuItemsFileUrl) else { return }
        let rates = (try? JSONDecoder().decode([String: ExchangeRate].self, from: data)) ?? [:]
        self.exchangeRates = rates
    }
    
    static func saveRates() {
        if let data = try? JSONEncoder().encode(self.exchangeRates) {
            try? data.write(to: menuItemsFileUrl)
        }
    }
    
    static func loadSampleRates() -> [ExchangeRate] {
        let rate1 = ExchangeRate(rates: ["HUF": 338.15, "ZAR": 16.4204, "AUD": 1.6417, "DKK": 7.4724, "RUB": 70.0203, "CHF": 1.0705, "IDR": 15063.25, "BGN": 1.9558, "HKD": 8.5168, "ILS": 3.7585, "MXN": 20.5281, "SEK": 10.5455, "JPY": 120.51, "NZD": 1.7094, "SGD": 1.5255, "KRW": 1309.78, "CZK": 25.03, "THB": 34.333, "CAD": 1.4604, "CNY": 7.6711, "PHP": 55.816, "NOK": 10.1673, "INR": 78.3625, "GBP": 0.8472, "MYR": 4.5412, "HRK": 7.455, "TRY": 6.5688, "USD": 1.0969, "RON": 4.7613, "BRL": 4.7078, "ISK": 137.9, "PLN": 4.2653], base: "EUR", date: "2020-02-07")
        return [rate1]
    }
    
    
    
    static func loadRemoteRates() {
        let baseURL = URL(string: "https://api.exchangeratesapi.io/latest")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        for currency in currencies {
            components?.queryItems = [URLQueryItem(name: "base", value: currency)]
            let url = components!.url!
            print(url)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data, let rate = try? jsonDecoder.decode(ExchangeRate.self, from: data) {
                    self.exchangeRates[currency] = rate
                } else {
                    print("Error getting currency exchange rate")
                }
            }
                task.resume()
        }
    }
}

//AUD    Australian dollar    1.6373     AUD
//BGN    Bulgarian lev    1.9558     BGN
//BRL    Brazilian real    4.7210     BRL
//CAD    Canadian dollar    1.4580     CAD
//CHF    Swiss franc    1.0700     CHF
//CNY    Chinese yuan renminbi    7.6471     CNY
//CZK    Czech koruna    25.026     CZK
//DKK    Danish krone    7.4724     DKK
//GBP    Pound sterling    0.84628     GBP
//HKD    Hong Kong dollar    8.5039     HKD
//HRK    Croatian kuna    7.4550     HRK
//HUF    Hungarian forint    337.37     HUF
//IDR    Indonesian rupiah    15037.15     IDR
//ILS    Israeli shekel    3.7483     ILS
//INR    Indian rupee    78.1070     INR
//ISK    Icelandic krona    137.90     ISK
//JPY    Japanese yen    120.18     JPY
//KRW    South Korean won    1301.41     KRW
//MXN    Mexican peso    20.5466     MXN
//MYR    Malaysian ringgit    4.5425     MYR
//NOK    Norwegian krone    10.1188     NOK
//NZD    New Zealand dollar    1.7108     NZD
//PHP    Philippine peso    55.657     PHP
//PLN    Polish zloty    4.2656     PLN
//RON    Romanian leu    4.7663     RON
//RUB    Russian rouble    70.1120     RUB
//SEK    Swedish krona    10.5728     SEK
//SGD    Singapore dollar    1.5209     SGD
//THB    Thai baht    34.277     THB
//TRY    Turkish lira    6.5897     TRY
//USD    US dollar    1.0951     USD
//ZAR    South African rand
