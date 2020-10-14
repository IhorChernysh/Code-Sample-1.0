//
//  Coordinator.swift
//  TestCoordinatorApp
//
//  Created by ihor-ios on 25.05.2020.
//  Copyright © 2020 PULS. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func finish(coordinator: Coordinator)
}
