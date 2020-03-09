//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CurrencySelectTableViewControllerDelegate {

    var exchangeRates: ExchangeRates?
    let saverLoader = DataManager()
    let converter = Converter()
    
    var convertFrom: Currency?
    var convertTo: Currency?

    @IBOutlet var amountToConvert: UITextField!
    @IBOutlet var resultAmount: UILabel!

    @IBAction func amountToConvertChanged() {
        convert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saverLoader.loadExchangeRates(for: self)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //select RUB to EUR as defaults
        convertFrom = Currency.RUB
        convertTo = Currency.EUR
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func convert() {
        if let from = convertFrom, let to = convertTo {
            resultAmount.text = converter.convert(amountToConvert.text, exchangeRates?.rates[from.rawValue]?.rates[to.rawValue], formatter: NumberFormatter())
        }
    }
    
    func updateSelectedCurrencies() {
        
    }
    
    func didSelect(currency: Currency, type selection: String) {
        switch selection {
        case "convertTo":
            self.convertTo = currency
            print("Converting to \(self.convertTo!.rawValue)")
        case "convertFrom":
            self.convertFrom = currency
            print("Converting from \(self.convertFrom!.rawValue)")
        default:
            return
        }
        updateSelectedCurrencies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? CurrencySelectTableViewController
        if segue.identifier == "ConvertTo" {
            destinationViewController?.selectionType = "convertTo"
            if let currency = self.convertTo {
                destinationViewController?.currency = currency
            }
        }
        if segue.identifier == "ConvertFrom" {
            destinationViewController?.selectionType = "convertFrom"
            if let currency = self.convertFrom {
                destinationViewController?.currency = currency
            }
        }
        destinationViewController?.delegate = self
    }
    
    @IBAction func unwindFromCurrencySelection(segue: UIStoryboardSegue) {
    }
 
    // MARK: App State Restoration
    
//    override func encodeRestorableState(with coder: NSCoder) {
//        super.encodeRestorableState(with: coder)
//
//        coder.encode(convertFrom, forKey: "convertFrom")
//        coder.encode(convertTo, forKey: "converTo")
//        coder.encode(sourcePicker.selectedRow(inComponent: 0), forKey: "sourcePickerSelectedRow")
//        coder.encode(goalPicker.selectedRow(inComponent: 0), forKey: "goalPickerSelectedRow")
//        coder.encode(amountToConvert.text, forKey: "amountToConvert")
//
//        print("items encoded")
//
//    }
//
//    override func decodeRestorableState(with coder: NSCoder) {
//        super.decodeRestorableState(with: coder)
//
//        let convertFrom = coder.decodeObject(forKey: "convertFrom") as! String
//        let convertTo = coder.decodeObject(forKey: "convertTo") as! String
//        let sourcePickerSelectedRow = coder.decodeInteger(forKey: "sourcePickerSelectedRow")
//        let goalPickerSelecterRow = coder.decodeInteger(forKey: "goalPickerSelectedRow")
//        let amountToConvert = coder.decodeObject(forKey: "amountToConvert") as! String
//
//        self.convertFrom = convertFrom
//        self.convertTo = convertTo
//        self.sourcePicker.selectRow(sourcePickerSelectedRow, inComponent: 0, animated: false)
//        self.goalPicker.selectRow(goalPickerSelecterRow, inComponent: 0, animated: false)
//        self.amountToConvert.text = amountToConvert
//
//    }
}

