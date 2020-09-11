//
//  CurrencySelectionViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class CurrencySelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var currencySelectionView: CurrencySelectionView
    var viewModel: HomeViewModel
    
    weak var coordinator: MainCoordinator?
    
    var tableView: UITableView!
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = currencySelectionView
    }
    
    init(viewModel: HomeViewModel, view: CurrencySelectionView) {
        self.viewModel = viewModel
        self.currencySelectionView = view
        super.init(nibName: nil, bundle: nil)
        
        setupUiElements()
        setupViewModel()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUiElements() {
        textField = currencySelectionView.textField
        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        tableView = currencySelectionView.tableView
    }
    
    private func setupViewModel() {
        viewModel.filterString = ""
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CurrencyCell")
    }
    
    @objc func textFieldValueChanged() {
        if let text = textField.text {
            viewModel.filterString = text
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currency.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currency = viewModel.currency[indexPath.row]
        viewModel.didSelectCurrency(currency: currency, type: viewModel.selectionType)
        coordinator?.dismissViewController()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        let currency = viewModel.currency[indexPath.row]
        
        cell.textLabel?.text = currency.rawValue
        
        let type = viewModel.selectionType
        let to = viewModel.convertTo.value
        let from = viewModel.convertFrom.value
        
        if (type == .To && currency == to) || (type == .From && currency == from) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
