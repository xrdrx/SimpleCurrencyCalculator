//
//  SaverLoader.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 18.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation
import UIKit

struct SaverLoader {
    
    func loadRates(from file: URL) -> ExchangeRates? {
        guard let data = try? Data(contentsOf: file) else { return nil }
        let rates = (try? JSONDecoder().decode(ExchangeRates.self, from: data))
        return rates
    }
    
    func saveRates(_ rates: ExchangeRates, to file: URL) {
        if let data = try? JSONEncoder().encode(rates) {
            try? data.write(to: file)
        }
    }
    
    func saveExchangeRates(for controller: ViewController) {
        guard let rates = controller.exchangeRates else { return }
        saveRates(rates, to: exchangeRatesFileUrl)
    }
    
    func loadExchangeRates(for controller: ViewController) {
        controller.exchangeRates = loadRates(from: exchangeRatesFileUrl)
        loadRemoteRates(from: exchangeRatesRemoteUrl, for: Currency.allCases, update: controller.exchangeRates) { (rates) in
            controller.exchangeRates = rates
        }
    }
    
    func loadRemoteRates(from url: URL, for currencies: Currency.AllCases, update currentRates: ExchangeRates?, completion: @escaping (ExchangeRates) -> Void) {
        var exchangeRates = currentRates ?? ExchangeRates(rates: [:])
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        for currency in currencies {
            components?.queryItems = [URLQueryItem(name: "base", value: currency.rawValue)]
            let modifiedUrl = components!.url!
            print(modifiedUrl)
            let task = URLSession.shared.dataTask(with: modifiedUrl) { (data, response, error) in
                if let data = data, let rate = try? JSONDecoder().decode(ExchangeRate.self, from: data) {
                    exchangeRates.rates[currency.rawValue] = rate
                    completion(exchangeRates)
                } else {
                    print("Error getting currency exchange rate")
                }
            }
            task.resume()
        }
    }
}
