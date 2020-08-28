//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.02.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {

    let viewModel = HomeViewModel()
    weak var coordinator: MainCoordinator?

    @IBOutlet var convertFromLabel: UILabel!
    @IBOutlet var convertToLabel: UILabel!
    @IBOutlet var amountToConvert: UITextField!
    @IBOutlet var resultAmount: UILabel!
    
    @IBAction func convertToButtonTapped(_ sender: Any) {
        coordinator?.showCurrencySelectionView(viewModel: viewModel)
        viewModel.selectionType = .To
    }
    
    @IBAction func convertFromButtonTapped(_ sender: Any) {
        coordinator?.showCurrencySelectionView(viewModel: viewModel)
        viewModel.selectionType = .From
    }
    
    @IBAction func amountToConvertChanged() {
        viewModel.amountToConvert = amountToConvert?.text ?? ""
        viewModel.convertAndUpdateResultText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupKeyboardDismissByTap()
    }
    
    private func setupViewModel() {
        viewModel.convertFrom.bind { [weak self] convertFrom in
            self?.convertFromLabel.text = convertFrom.rawValue
        }
        viewModel.convertTo.bind { [weak self] convertTo in
            self?.convertToLabel.text = convertTo.rawValue
        }
        viewModel.resultAmount.bind { [weak self] result in
            self?.resultAmount.text = result
        }
    }
    
    private func setupKeyboardDismissByTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

