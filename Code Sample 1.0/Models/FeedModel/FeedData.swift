//
//  FeedData.swift
//  p153-ios
//
//  Created by ihor-ios on 15.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit

protocol FeedDataLayer {
}

struct FeedData: Decodable {
    var id: String?
    var text: String?
    var image: FeedImage?
    
    var age: String?
    var bestPlaces: String?
    var bestThings: String?
    var bestVacation: String?
    var books: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case image
        case age
    }
    
    init() {
    }
}


enum FeedDataUpdates: String {
    case age = "Alter: "
    case bestPlaces = "Der Ort, den ich besonders mag: "
    case bestThings = "Das zeichnet mich aus: "
    case bestVacation = "So reise ich gerne: "
    case books = "Meine Lieblingsbücher: "
}
