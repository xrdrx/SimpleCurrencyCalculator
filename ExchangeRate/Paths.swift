//
//  Paths.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 18.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
 
let exchangeRatesFileUrl = documentsDirectoryUrl.appendingPathComponent("exchangeRates").appendingPathExtension("json")

let exchangeRatesRemoteUrl = URL(string: "https://api.exchangeratesapi.io/latest")!
