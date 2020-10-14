//
//  Feed.swift
//  p153-ios
//
//  Created by ihor-ios on 15.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

struct Feed: Decodable {
    var profileID: String?
    var type: FeedType?
    var profile: FeedProfile?
    var data: FeedData?
    var status: String?
    
    private enum CodingKeys: String, CodingKey {
        case profileID = "profile_id"
        case type
        case profile
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.profileID = try container.decode(String.self, forKey: .profileID)
        self.type = try container.decodeIfPresent(FeedType.self, forKey: .type)
        self.profile = try container.decodeIfPresent(FeedProfile.self, forKey: .profile)
        self.data = try? container.decodeIfPresent(FeedData.self, forKey: .data)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
    }
    
    init(profileID: String) {
        self.profileID = profileID
    }
}
