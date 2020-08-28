//
//  Converter.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 18.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

class Converter {
    let formatter = CurrencyFormatter()
    
    func convert(_ amount: NSNumber,_ rate: NSNumber) -> (String, String) {
        let result = amount.decimalValue * rate.decimalValue
        let resultText = convertDecimalNumberToText(number: result as NSNumber)
        let amountText = convertDecimalNumberToText(number: amount)
        return (amountText, resultText)
    }
    
    func convertDecimalNumberToText(number: NSNumber) -> String {
        guard let string = formatter.string(from: number) else { return "" }
        return string
    }
}

class CurrencyFormatter: NumberFormatter {
    override init() {
        super.init()
        self.maximumFractionDigits = 2
        self.usesGroupingSeparator = true
        self.groupingSize = 3
        self.groupingSeparator = " "
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
