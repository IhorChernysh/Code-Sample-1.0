//
//  BaseCoordinator.swift
//  p153MaunFlow
//
//  Created by ihor-ios on 25.05.2020.
//  Copyright © 2020 PULS. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController = UINavigationController()
        
    // MARK: - Methods
    
    func start() {
        fatalError("Must be implemented")
    }
    
    func start(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
        self.parentCoordinator = coordinator
    }
    
    func finish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}
