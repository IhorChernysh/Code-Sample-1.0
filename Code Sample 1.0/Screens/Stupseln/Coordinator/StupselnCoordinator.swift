//
//  StupselnCoordinator.swift
//  p153-ios
//
//  Created by ihor-ios on 10.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

class StupselnCoordinator: BaseCoordinator {
 
    let stupselnViewModel = StupselnViewModel()
    
    override func start() {
        let vc = StupselnViewController(viewModel: stupselnViewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
