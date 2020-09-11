//
//  SaverLoader.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 18.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation
import UIKit

protocol ExchangeRatesStorage {
    func saveExchangeRates(_ rates: ExchangeRates)
    func loadLocalExchangeRates() -> ExchangeRates
}

class DefaultExchangeRatesStorage: ExchangeRatesStorage {
    
    private func getDocumentsDirectoryUrl() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    private func getExchangeRatesFileUrl() -> URL {
        let documentsDirectory = getDocumentsDirectoryUrl()
        return documentsDirectory.appendingPathComponent("exchangeRates").appendingPathExtension("json")
    }
    
    func saveExchangeRates(_ rates: ExchangeRates) {
        guard let data = try? JSONEncoder().encode(rates) else { return }
        let url = getExchangeRatesFileUrl()
        try? data.write(to: url)
    }
    
    func loadLocalExchangeRates() -> ExchangeRates {
        let url = getExchangeRatesFileUrl()
        guard let data = try? Data(contentsOf: url) else { return ExchangeRates(rates: [:]) }
        guard let rates = try? JSONDecoder().decode(ExchangeRates.self, from: data) else { return ExchangeRates(rates: [:]) }
        return rates
    }
}
