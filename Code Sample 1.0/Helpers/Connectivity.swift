//
//  Connectivity.swift
//  p153-ios
//
//  Created by ihor-ios on 19.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
