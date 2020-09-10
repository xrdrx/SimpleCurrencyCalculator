//
//  Factory.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

protocol Factory {
    func makeHomeViewController() -> HomeViewController
    func makeHomeViewModel() -> HomeViewModel
    func makeHomeView() -> HomeView
    
    func makeCurrencySelectionController(viewModel: HomeViewModel) -> CurrencySelectionViewController
    func makeCurrencySelectionView() -> CurrencySelectionView
    
    func makeNetworkService() -> NetworkService
    func makeExchangeRatesProvider() -> ExchangeRatesProvider
    func makeConverter() -> Converter
}

class DefaultFactory: Factory {

    func makeHomeViewController() -> HomeViewController {
        let model = makeHomeViewModel()
        let view = makeHomeView()
        return HomeViewController(viewModel: model, view: view)
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        let provider = makeExchangeRatesProvider()
        let converter = makeConverter()
        return HomeViewModel(ratesProvider: provider, converter: converter)
    }
    
    func makeHomeView() -> HomeView {
        return HomeView()
    }
    
    func makeCurrencySelectionController(viewModel: HomeViewModel) -> CurrencySelectionViewController {
        let view = makeCurrencySelectionView()
        return CurrencySelectionViewController(viewModel: viewModel, view: view)
    }
    
    func makeCurrencySelectionView() -> CurrencySelectionView {
        return CurrencySelectionView()
    }
    
    func makeNetworkService() -> NetworkService {
        return DefaultNetworkService()
    }
    
    func makeExchangeRatesProvider() -> ExchangeRatesProvider {
        let service = makeNetworkService()
        return ExchangeRatesApiIo(networkService: service)
    }
    
    func makeConverter() -> Converter {
        return Converter()
    }
}
