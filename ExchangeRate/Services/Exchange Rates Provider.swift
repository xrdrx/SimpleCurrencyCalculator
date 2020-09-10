//
//  Exchange Rates Provider.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

protocol ExchangeRatesProvider {
    var baseUrl: URL { get }
    var networkService: NetworkService { get set }
    
    func getExchangeRatesFor(currency: Currency, completion: @escaping (ExchangeRate) -> Void)
    func getQueryItemsFor(currency: Currency) -> URLQueryItem
}

class ExchangeRatesApiIo: ExchangeRatesProvider {
    
    let baseUrl: URL = URL(string: "https://api.exchangeratesapi.io/latest")!
    let queryItemNameForSingleCurrency: String = "base"
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getExchangeRatesFor(currency: Currency, completion: @escaping (ExchangeRate) -> Void) {
        let queryItem = getQueryItemsFor(currency: currency)
        let url = networkService.getUrlWithQueryItems(url: baseUrl, queryItems: [queryItem])
        networkService.getDataFromUrl(url) { (data) in
            if let exchangeRate = try? JSONDecoder().decode(ExchangeRate.self, from: data) {
                print("Got data for \(currency.rawValue)")
                completion(exchangeRate)
            }
        }
    }
    
    func getQueryItemsFor(currency: Currency) -> URLQueryItem {
        return URLQueryItem(name: queryItemNameForSingleCurrency, value: currency.rawValue)
    }
}
    

