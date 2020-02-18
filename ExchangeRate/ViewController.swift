//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var exchangeRates: ExchangeRates?
    let saverLoader = SaverLoader()
    let converter = Converter()
    
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
        
        saverLoader.loadExchangeRates(for: self)
        
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
        sourcePicker.selectRow(Currency.allCases.firstIndex(of: .RUB)!, inComponent: 0, animated: false)
        goalPicker.selectRow(Currency.allCases.firstIndex(of: .EUR)!, inComponent: 0, animated: false)
        convertFrom = Currency.RUB.rawValue
        convertTo = Currency.EUR.rawValue
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Currency.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Currency.allCases[row].rawValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case sourcePicker:
            convertFrom = Currency.allCases[row].rawValue
        case goalPicker:
            convertTo = Currency.allCases[row].rawValue
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
        if let from = convertFrom, let to = convertTo {
            resultAmount.text = converter.convert(amountToConvert.text, exchangeRates?.rates[from]?.rates[to], formatter: NumberFormatter())
        }
    }
 
    // MARK: App State Restoration
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        coder.encode(convertFrom, forKey: "convertFrom")
        coder.encode(convertTo, forKey: "converTo")
        coder.encode(sourcePicker.selectedRow(inComponent: 0), forKey: "sourcePickerSelectedRow")
        coder.encode(goalPicker.selectedRow(inComponent: 0), forKey: "goalPickerSelectedRow")
        coder.encode(amountToConvert.text, forKey: "amountToConvert")
        
        print("items encoded")
        
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        let convertFrom = coder.decodeObject(forKey: "convertFrom") as! String
        let convertTo = coder.decodeObject(forKey: "convertTo") as! String
        let sourcePickerSelectedRow = coder.decodeInteger(forKey: "sourcePickerSelectedRow")
        let goalPickerSelecterRow = coder.decodeInteger(forKey: "goalPickerSelectedRow")
        let amountToConvert = coder.decodeObject(forKey: "amountToConvert") as! String
        
        self.convertFrom = convertFrom
        self.convertTo = convertTo
        self.sourcePicker.selectRow(sourcePickerSelectedRow, inComponent: 0, animated: false)
        self.goalPicker.selectRow(goalPickerSelecterRow, inComponent: 0, animated: false)
        self.amountToConvert.text = amountToConvert
        
    }
}

