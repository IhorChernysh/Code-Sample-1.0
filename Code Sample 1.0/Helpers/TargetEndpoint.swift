//
//  TargetEndpoint.swift
//  p153-ios
//
//  Created by ihor-ios on 16.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "https:*************"

protocol TargetEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var header: HTTPHeader? { get }
}
