//
//  UICollectionView+Ext.swift
//  p153-ios
//
//  Created by Игорь Черныш on 04.08.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

extension UICollectionView {
    func reloadData(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completion()
            }
        }
    }
    
    func reloadDataThenPerform(_ closure: @escaping (() -> Void)) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(closure)
        self.reloadData()
        CATransaction.commit()
    }
}
