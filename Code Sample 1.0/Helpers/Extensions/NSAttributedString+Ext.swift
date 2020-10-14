//
//  NSAttributedString+Ext.swift
//  p153-ios
//
//  Created by ihor-ios on 03.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

extension NSAttributedString {
    func uppercased() -> NSAttributedString {
        
        let result = NSMutableAttributedString(attributedString: self)
        
        result.enumerateAttributes(in: NSRange(location: 0, length: length), options: []) {_, range, _ in
            result.replaceCharacters(in: range, with: (string as NSString).substring(with: range).uppercased())
        }
        
        return result
    }
}
