//
//  AttributeValue.swift
//  p153-ios
//
//  Created by Macbook Air 13 on 19.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

protocol AttributeValueLayer: Decodable {
    var attributeID: Int { get }
    var name: String { get }
    var sortKey: Int { get }
    var enumID: Int { get }
    var multiple: Bool { get }
}

struct AttributeValue: AttributeValueLayer {
    var attributeID: Int
    var name: String
    var sortKey: Int
    var enumID: Int
    var multiple: Bool
    
    var others: [String]?
    
    enum CodingKeys: String, CodingKey {
        case attributeID = "attribute_id"
        case name
        case sortKey = "sort_key"
        case enumID = "enum_id"
        case multiple
    }
}
