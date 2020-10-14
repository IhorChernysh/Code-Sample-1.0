//
//  FeedImage.swift
//  p153-ios
//
//  Created by ihor-ios on 15.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

struct FeedImage: Decodable {
    var thumbnails: FeedThumbnails
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case thumbnails
        case description
    }
    
    init(feedThumbnails: FeedThumbnails) {
        self.thumbnails = feedThumbnails
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.thumbnails = try container.decode(FeedThumbnails.self, forKey: .thumbnails)
        self.description = try? container.decodeIfPresent(String.self, forKey: .description)
    }
}

struct FeedThumbnails: Decodable {
    var fiveHundred: FeedThumbnailURL
    var twoFifty: FeedThumbnailURL
    var oneTwenty: FeedThumbnailURL
    var eighty: FeedThumbnailURL
    var fifty: FeedThumbnailURL
    
    private enum CodingKeys: String, CodingKey {
        case fiveHundred = "500"
        case twoFifty = "250"
        case oneTwenty = "120"
        case eighty = "80"
        case fifty = "50"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fiveHundred = try container.decode(FeedThumbnailURL.self, forKey: .fiveHundred)
        self.twoFifty = try container.decode(FeedThumbnailURL.self, forKey: .twoFifty)
        self.oneTwenty = try container.decode(FeedThumbnailURL.self, forKey: .oneTwenty)
        self.eighty = try container.decode(FeedThumbnailURL.self, forKey: .eighty)
        self.fifty = try container.decode(FeedThumbnailURL.self, forKey: .fifty)
    }
}

struct FeedThumbnailURL: Decodable {
    var url: String
    
    private enum CodingKeys: String, CodingKey {
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
