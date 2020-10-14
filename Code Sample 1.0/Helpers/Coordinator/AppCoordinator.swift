//
//  AppCoordinator.swift
//  p153MaunFlow
//
//  Created by ihor-ios on 25.05.2020.
//  Copyright © 2020 PULS. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    
    private var window: UIWindow?
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Methods
    
    override func start() {
        window?.makeKeyAndVisible()
        
        launchInitialVC()
    }
    
    // MARK: - Private methods
    
    private func launchInitialVC() {
        if let isLoggedIn = UserDefaults.standard.value(forKey: UserDefaultsKeys.loggedIn.rawValue) as? Bool {
            isLoggedIn ? lauchFeedVC() : launchStartVC()
        } else {
            launchStartVC()
        }
    }
    
    private func lauchFeedVC() {
//        let feedViewModel = FeedViewModel()
//        let coordinator = FeedCoordinator(feedViewModel: feedViewModel)
//        coordinator.start()
//        self.start(coordinator: coordinator)
//        let rootVC = UINavigationController(rootViewController: BaseTabBarController(feedViewModel: feedViewModel))
//        coordinator.navigationController = rootVC
//
//        window?.rootViewController = rootVC
    }
    
    private func launchStartVC() {
    }
    
    private func launchPlayerVC() {
    }
}
