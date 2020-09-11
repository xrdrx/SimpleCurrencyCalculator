//
//  Exchange Rates Provider.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

protocol ExchangeRatesProvider {
    func getExchangeRatesFor(currency: Currency, completion: @escaping (ExchangeRate) -> Void)
}

class ExchangeRatesApiIo: ExchangeRatesProvider {
    
    private let baseUrl: URL = URL(string: "https://api.exchangeratesapi.io/latest")!
    private let queryItemNameForSingleCurrency: String = "base"
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getExchangeRatesFor(currency: Currency, completion: @escaping (ExchangeRate) -> Void) {
        let queryItem = getQueryItemsFor(currency: currency)
        let url = networkService.getUrlWithQueryItems(url: baseUrl, queryItems: [queryItem])
        networkService.getDataFromUrl(url) { (data) in
            if let exchangeRate = try? JSONDecoder().decode(ExchangeRate.self, from: data) {
                completion(exchangeRate)
            }
        }
    }
    
    private func getQueryItemsFor(currency: Currency) -> URLQueryItem {
        return URLQueryItem(name: queryItemNameForSingleCurrency, value: currency.rawValue)
    }
}
    

