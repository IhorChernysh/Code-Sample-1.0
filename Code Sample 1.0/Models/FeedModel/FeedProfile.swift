//
//  FeedProfile.swift
//  p153-ios
//
//  Created by ihor-ios on 15.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

struct FeedProfile: Decodable {
    var profileID: String
    var nickname: String
    var plusStatus: Bool
    var gender: String
    var age: String
    var verifiedStatus: Bool
    var city: String
    var favorited: Bool
    var friended: Bool
    var liked: Bool
    var stupseled: Bool
    var superuser: Bool
    var defaultImageURL50: String
    var defaultImageURL80: String
    var defaultImageURL120: String
    var defaultImageURL250: String
    var defaultImageURL500: String
    
    enum CodingKeys: String, CodingKey {
        case profileID = "profile_id"
        case nickname
        case plusStatus = "plus_status"
        case gender
        case age
        case verifiedStatus = "verified_status"
        case city
        case favorited
        case friended
        case liked
        case stupseled
        case superuser
        case defaultImageURL50 = "default_image_url_50"
        case defaultImageURL80 = "default_image_url_80"
        case defaultImageURL120 = "default_image_url_120"
        case defaultImageURL250 = "default_image_url_250"
        case defaultImageURL500 = "default_image_url_500"
    }
}
