//
//  CurrencySelectTableViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 09.03.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

protocol CurrencySelectTableViewControllerDelegate: class {
    func didSelect(currency: Currency, type selection: String)
}

class CurrencySelectTableViewController: UITableViewController {
    
    var currency: Currency?
    var selectionType: String?
    weak var delegate: CurrencySelectTableViewControllerDelegate?

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
        currency = Currency.allCases[indexPath.row]
        delegate?.didSelect(currency: currency!, type: selectionType!)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        // Configure the cell...
        let currency = Currency.allCases[indexPath.row]
        
        cell.textLabel?.text = currency.rawValue
        if currency == self.currency {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
