//
//  MainCoordinator.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 20.03.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let factory = DefaultFactory()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = factory.makeHomeViewController()
        vc.coordinator = self
        vc.title = "Currency Converter"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showCurrencySelectionView(viewModel model: HomeViewModel) {
        let vc = factory.makeCurrencySelectionController(viewModel: model)
        vc.coordinator = self
        navigationController.present(vc, animated: true)
    }
    
    func dismissViewController() {
        if let presentedViewController = navigationController.presentedViewController {
            presentedViewController.dismiss(animated: true, completion: nil)
        }
    }
}
