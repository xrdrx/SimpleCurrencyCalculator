//
//  SaverLoader.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 18.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation
import UIKit

struct DataManager {
    
    func loadLocalRates(from file: URL) -> ExchangeRates {
        guard let data = try? Data(contentsOf: file) else { return ExchangeRates(rates: [:]) }
        if let rates = (try? JSONDecoder().decode(ExchangeRates.self, from: data)) {
            return rates
        } else {
            return ExchangeRates(rates: [:])
        }
    }
    
    func saveRates(_ rates: ExchangeRates, to file: URL) {
        if let data = try? JSONEncoder().encode(rates) {
            try? data.write(to: file)
        }
    }
    
    func saveExchangeRates(_ rates: ExchangeRates) {
        saveRates(rates, to: exchangeRatesFileUrl)
    }
    
//    func loadRemoteRates() -> ExchangeRates {
//        var exchangeRates = ExchangeRates(rates: [:])
//        loadRemoteRates(from: exchangeRatesRemoteUrl, for: Currency.allCases) { (rates) in
//            exchangeRates = rates
//        }
//        return exchangeRates
//    }
    
    func loadRemoteRates(from url: URL, for currencies: Currency.AllCases, completion: @escaping (ExchangeRate) -> Void) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        for currency in currencies {
            components?.queryItems = [URLQueryItem(name: "base", value: currency.rawValue)]
            let modifiedUrl = components!.url!
            print(modifiedUrl)
            let task = URLSession.shared.dataTask(with: modifiedUrl) { (data, response, error) in
                if let data = data, let rate = try? JSONDecoder().decode(ExchangeRate.self, from: data) {
                    completion(rate)
                } else {
                    print("Error getting currency exchange rate")
                }
            }
            task.resume()
        }
    }
}
