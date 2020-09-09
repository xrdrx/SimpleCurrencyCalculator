//
//  testViewController.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 09.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    let viewModel = HomeViewModel()
    
    weak var coordinator: MainCoordinator?
    
    var convertFromLabel: UILabel!
    var convertToLabel: UILabel!
    var amountToConvert: UITextField!
    var resultAmount: UILabel!
    var fromButton: UIButton!
    var toButton: UIButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        convertFromLabel = homeView.convertFromLabel
        convertToLabel = homeView.convertToLabel
        amountToConvert = homeView.amount
        resultAmount = homeView.result
        fromButton = homeView.fromButton
        toButton = homeView.toButton
        
        toButton.addTarget(self, action: #selector(convertToButtonTapped), for: .touchUpInside)
        fromButton.addTarget(self, action: #selector(convertFromButtonTapped), for: .touchUpInside)
        amountToConvert.addTarget(self, action: #selector(amountToConvertChanged), for: .editingChanged)
        
        setupViewModel()
        setupKeyboardDismissByTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
    }
    
    @objc func convertToButtonTapped() {
        coordinator?.showCurrencySelectionView(viewModel: viewModel)
        viewModel.selectionType = .To
    }
    
    @objc func convertFromButtonTapped() {
        coordinator?.showCurrencySelectionView(viewModel: viewModel)
        viewModel.selectionType = .From
    }
    
    @objc func amountToConvertChanged() {
        viewModel.rawAmountToConvert = amountToConvert?.text ?? ""
        amountToConvert.text = viewModel.formattedAmountToConvert
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
