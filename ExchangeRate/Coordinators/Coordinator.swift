//
//  Coordinator.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 20.03.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
