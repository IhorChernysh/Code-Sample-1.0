//
//  TimeInterval+Ext.swift
//  p153-ios
//
//  Created by Игорь Черныш on 27.07.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

extension TimeInterval {

    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        
        if time >= 3600 {
            //let minutes = time / 60
            return String(format: "%0.2d:%0.2d:%0.2d",hours, minutes,seconds)
            //return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        } else {
            let minutes = (time / 60) % 60
            return String(format: "%0.2d:%0.2d",minutes,seconds)
        }
    }
}
