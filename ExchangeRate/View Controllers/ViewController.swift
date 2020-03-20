//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = HomeViewModel()

    @IBAction func convertToButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ConvertTo", sender: sender)
    }
    @IBAction func convertFromButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ConvertFrom", sender: sender)
    }
    
    @IBOutlet var convertFromLabel: UILabel!
    @IBOutlet var convertToLabel: UILabel!
    @IBOutlet var amountToConvert: UITextField!
    @IBOutlet var resultAmount: UILabel!

    @IBAction func amountToConvertChanged() {
        viewModel.amountToConvert = amountToConvert?.text ?? ""
        viewModel.convert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.convertFrom.bind { [weak self] convertFrom in
            self?.convertFromLabel.text = convertFrom.rawValue
        }
        viewModel.convertTo.bind { [weak self] convertTo in
            self?.convertToLabel.text = convertTo.rawValue
        }
        viewModel.resultAmount.bind { [weak self] result in
            self?.resultAmount.text = result
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? CurrencySelectTableViewController
        if segue.identifier == "ConvertTo" {
            viewModel.selectionType = .To
            }
        if segue.identifier == "ConvertFrom" {
            viewModel.selectionType = .From
            }
        destinationViewController?.viewModel = viewModel
    }
    
    @IBAction func unwindFromCurrencySelection(segue: UIStoryboardSegue) {
    }
}

