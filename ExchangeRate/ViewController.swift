//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var convertFrom: String?
    var convertTo: String?

    @IBOutlet var amountToConvert: UITextField!
    @IBOutlet var resultAmount: UILabel!
    @IBOutlet var sourcePicker: UIPickerView!
    @IBOutlet var goalPicker: UIPickerView!
    
    @IBAction func amountToConvertChanged() {
        convert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExchangeRate.loadRates()
        ExchangeRate.loadRemoteRates()
        
        sourcePicker.dataSource = self
        sourcePicker.delegate = self
        goalPicker.dataSource = self
        goalPicker.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //select RUB to EUR as defaults
        sourcePicker.selectRow(26, inComponent: 0, animated: false)
        goalPicker.selectRow(8, inComponent: 0, animated: false)
        convertFrom = ExchangeRate.currencies[26]
        convertTo = ExchangeRate.currencies[8]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return ExchangeRate.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return ExchangeRate.currencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sourcePicker:
            convertFrom = ExchangeRate.currencies[row]
        case goalPicker:
            convertTo = ExchangeRate.currencies[row]
        default:
            return
        }
        
        convert()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func convert() {
        guard let text = amountToConvert.text,
            let convertTo = convertTo,
            let convertFrom = convertFrom,
            let amountInDouble = Double(text),
            let rate = ExchangeRate.exchangeRates[convertFrom]?.rates[convertTo] else { return }
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        let amount: Decimal = NSNumber(floatLiteral: amountInDouble).decimalValue
        let exchangeRate: Decimal = NSNumber(floatLiteral: rate).decimalValue
        let result = amount * exchangeRate
        
        resultAmount.text = formatter.string(from: result as NSDecimalNumber)
    }
    
}

