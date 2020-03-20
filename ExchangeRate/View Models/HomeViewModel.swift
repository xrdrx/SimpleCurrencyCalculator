//
//  ViewControllerViewModel.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 19.03.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

class HomeViewModel {
    var exchangeRates = ExchangeRates(rates: [:])
    let manager = DataManager()
    let converter = Converter()
    
    let convertFrom: Box<Currency> = Box(Currency.RUB)
    let convertTo: Box<Currency> = Box(Currency.EUR)
    let resultAmount = Box("")
    var amountToConvert: String = ""
    var selectionType: Convertion = .From
    
    var currency = Currency.allCases
    var filterString: String = "" {
        didSet {
            currency = Currency.allCases.filter { $0.rawValue.hasPrefix(filterString) }
        }
    }
    
    init() {
        self.exchangeRates = manager.loadLocalRates(from: exchangeRatesFileUrl)
        manager.loadRemoteRates(from: exchangeRatesRemoteUrl, for: Currency.allCases) { (rate) in
            self.exchangeRates.rates[rate.base] = rate
            print("Added \(rate.base) rates")
        }
    }
    
    func convert() {
        if amountToConvert == "" {
            resultAmount.value = ""
            return
        }
        let from = convertFrom.value
        let to = convertTo.value
        let rate = to == from ? 1 : exchangeRates.rates[from.rawValue]?.rates[to.rawValue]
        if let result = converter.convert(
            amountToConvert,
            rate,
            formatter: NumberFormatter()) {
            resultAmount.value = "\(amountToConvert) \(from.rawValue) = \(result) \(to.rawValue)"
        } else {
            return
        }
    }
    
    func didSelectCurrency(currency: Currency, type selection: Convertion) {
        switch selection {
        case .To:
            convertTo.value = currency
        case .From:
            convertFrom.value = currency
        }
        convert()
    }
    
    func saveRates() {
        manager.saveRates(exchangeRates, to: exchangeRatesFileUrl)
    }
}
