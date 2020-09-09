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
    
    var rawAmountToConvert: String = "" {
        didSet {
            didSetRawAmountToConvert()
        }
    }
    var strippedAmountToConvert: String = ""
    var formattedAmountToConvert: String = ""
    
    var selectionType: Convertion = .From
    var currency = Currency.allCases
    var filterString: String = "" {
        didSet {
            filterCurrencyArray()
        }
    }
    
    init() {
        self.exchangeRates = manager.loadLocalRates(from: exchangeRatesFileUrl)
        manager.loadRemoteRates(from: exchangeRatesRemoteUrl, for: Currency.allCases) { (rate) in
            self.exchangeRates.rates[rate.base] = rate
            print("Added \(rate.base) rates")
        }
    }
    
    private func didSetRawAmountToConvert() {
        setStrippedAmount()
        setFormattedAmount()
        convertAndUpdateResultText()
    }
    
    private func setStrippedAmount() {
        strippedAmountToConvert = removeWhiteSpacesFromString(rawAmountToConvert)
        strippedAmountToConvert = truncateDoubleInString(strippedAmountToConvert)
    }
    
    private func removeWhiteSpacesFromString(_ string: String) -> String {
        return string.components(separatedBy: .whitespaces).joined()
    }
    
    private func truncateDoubleInString(_ string: String) -> String {
        guard strippedAmountToConvertIsNumber() else { return string }
        if string.hasSuffix(".") { return string }
        let double = Double(string)!
        var result = NSDecimalNumber(value: double)
        result = result.multiplying(by: 100).rounding(accordingToBehavior: nil).dividing(by: 100)
        return result.stringValue
    }
    
    private func setFormattedAmount() {
        guard strippedAmountToConvertIsNumber() else {
            formattedAmountToConvert = rawAmountToConvert
            return
        }
        let truncatedAmount = truncateDoubleInString(strippedAmountToConvert)
        formattedAmountToConvert = getFormattedCurrencyString(truncatedAmount)
    }
    
    private func getFormattedCurrencyString(_ string: String) -> String {
        let number = NSNumber(value: Double(string)!)
        let formattedString = converter.convertDecimalNumberToText(number: number)
        if string.hasSuffix(".") { return formattedString + "." }
        return formattedString
    }
    
    func convertAndUpdateResultText() {
        guard let amount = getAmountToConvert(),
              let rate = getConvertionRate()
            else {
            resultAmount.value = ""
            return
        }
        let result = converter.convert(amount, rate)
        updateResultText(result)
    }
    
    private func getAmountToConvert() -> NSNumber? {
        guard strippedAmountToConvertIsNumber() else { return nil }
        return NSNumber(value: Double(strippedAmountToConvert)!)
    }
    
    private func strippedAmountToConvertIsNumber() -> Bool {
        return stringIsNumber(strippedAmountToConvert)
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
    
    private func filterCurrencyArray() {
        currency = Currency.allCases.filter { $0.rawValue.hasPrefix(filterString) }
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
