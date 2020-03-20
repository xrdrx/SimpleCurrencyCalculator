//
//  Converter.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 18.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

struct Converter {
    func convert(_ amount: String?,_ rate: Double?, formatter: NumberFormatter) -> String? {
        guard let amount = amount,
            let amountInDouble = formatter.number(from: amount),
            let rate = rate else { return nil}
        
        formatter.maximumFractionDigits = 2
        
        let startAmount: Decimal = amountInDouble.decimalValue
        let exchangeRate: Decimal = NSNumber(floatLiteral: rate).decimalValue
        let result = startAmount * exchangeRate
        if let result = formatter.string(from: result as NSDecimalNumber) {
            return result
        } else {
            return nil
        }
    }
}
