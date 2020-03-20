//
//  SearchTableViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 21.03.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController, Storyboarded, UITableViewDelegate, UITableViewDataSource {
    
    weak var viewModel: HomeViewModel?
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func textFieldValueChanged(_ sender: Any) {
        if let text = textField.text {
            viewModel!.filterString = text
            tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel!.filterString = ""
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.currency.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currency = viewModel!.currency[indexPath.row]
        viewModel!.didSelectCurrency(currency: currency, type: viewModel!.selectionType)
        coordinator?.dismissViewController()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        // Configure the cell...
        let currency = viewModel!.currency[indexPath.row]
        
        cell.textLabel?.text = currency.rawValue
        
        let type = viewModel!.selectionType
        let to = viewModel!.convertTo.value
        let from = viewModel!.convertFrom.value
        
        if (type == .To && currency == to) || (type == .From && currency == from) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
