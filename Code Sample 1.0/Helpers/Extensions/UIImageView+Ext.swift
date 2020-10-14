//
//  UIImageView+Ext.swift
//  p153-ios
//
//  Created by ihor-ios on 28.05.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
