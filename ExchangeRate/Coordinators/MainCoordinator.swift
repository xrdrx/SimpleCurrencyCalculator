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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

//    func start() {
//        let vc = HomeViewController.instantiate()
//        vc.coordinator = self
//        vc.title = "Currency Converter"
//        navigationController.pushViewController(vc, animated: false)
//    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        vc.title = "Currency Converter"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showCurrencySelectionView(viewModel model: HomeViewModel) {
        let vc = SearchTableViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = model
        navigationController.present(vc, animated: true)
    }
    
    func dismissViewController() {
        if let presentedViewController = navigationController.presentedViewController {
            presentedViewController.dismiss(animated: true, completion: nil)
        }
    }
}
