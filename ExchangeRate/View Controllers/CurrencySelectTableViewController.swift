//
//  CurrencySelectTableViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 09.03.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class CurrencySelectTableViewController: UITableViewController, Storyboarded {
    
    weak var viewModel: HomeViewModel?
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currency.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currency = Currency.allCases[indexPath.row]
        viewModel!.didSelectCurrency(currency: currency, type: viewModel!.selectionType)
        coordinator?.dismissViewController()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        // Configure the cell...
        let currency = Currency.allCases[indexPath.row]
        
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
