//
//  AttributeType.swift
//  p153-ios
//
//  Created by Macbook Air 13 on 19.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

struct AttributeType: Decodable {
    var ageRange: [AttributeValue] = []
    var bestPlaces: [AttributeValue] = []
    var bestThings: [AttributeValue] = []
    var bestVacation: [AttributeValue] = []
    var books: [AttributeValue] = []
    
    init() {}
    
    enum CodingKeys: String, CodingKey {
        case ageRange = "age_range"
        case bestPlaces = "best_places"
        case bestThings = "best_things"
        case bestVacation = "best_vacation"
        case books
    }
}
