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
    
    let convertFrom: Observable<Currency> = Observable(Currency.RUB)
    let convertTo: Observable<Currency> = Observable(Currency.EUR)
    let resultAmount = Observable("")
    var amountToConvert: String = ""
    var selectionType: Convertion = .From
    
    var currency = Currency.allCases
    var filterString: String = "" {
        didSet {
            filterCurrencyArray()
        }
    }
    
    private func filterCurrencyArray() {
        currency = Currency.allCases.filter { $0.rawValue.hasPrefix(filterString) }
    }
    
    init() {
        self.exchangeRates = manager.loadLocalRates(from: exchangeRatesFileUrl)
        manager.loadRemoteRates(from: exchangeRatesRemoteUrl, for: Currency.allCases) { (rate) in
            self.exchangeRates.rates[rate.base] = rate
            print("Added \(rate.base) rates")
        }
    }
    
    func convertAndUpdateResultText() {
        guard let amount = getAmountToCovert(),
              let rate = getConvertionRate()
            else {
            resultAmount.value = ""
            return
        }
        
        let result = converter.convert(amount, rate)
        updateResultText(result)
    }
    
    private func getAmountToCovert() -> NSNumber? {
        guard amountToConvertIsNumber() else { return nil }
        return NSNumber(value: Double(amountToConvert)!)
    }
    
    private func amountToConvertIsNumber() -> Bool {
        return stringIsNumber(amountToConvert)
    }
    
    private func stringIsNumber(_ string: String) -> Bool {
        return Double(string) != nil
    }
    
    private func getConvertionRate() -> NSNumber? {
        if convertFrom.value == convertTo.value { return 1 }
        if let rate = exchangeRates.rates[convertFrom.value.rawValue]?.rates[convertTo.value.rawValue] {
            return NSNumber(value: rate)
        }
        return nil
    }
    
    private func updateResultText(_ result: (String, String)) {
        resultAmount.value = "\(result.0) \(convertFrom.value.rawValue) =\n\(result.1) \(convertTo.value.rawValue)"
    }
    
    func didSelectCurrency(currency: Currency, type selection: Convertion) {
        switch selection {
        case .To:
            convertTo.value = currency
        case .From:
            convertFrom.value = currency
        }
        convertAndUpdateResultText()
    }
    
    func saveRates() {
        manager.saveRates(exchangeRates, to: exchangeRatesFileUrl)
    }
}
