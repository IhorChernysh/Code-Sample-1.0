//
//  Stupslers.swift
//  p153-ios
//
//  Created by Игорь Черныш on 25.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation
import RxDataSources

struct Stupslers: Decodable {
    var text: String
    var imageURLpng: String
    var isActive: Bool
    var coinActionID: Int
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case text
        case imageURLpng = "image_url_png"
        case isActive = "is_active"
        case coinActionID = "coin_action_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
        self.imageURLpng = try container.decode(String.self, forKey: .imageURLpng)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.coinActionID = try container.decode(Int.self, forKey: .coinActionID)
    }
}

extension Stupslers: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        return ""
    }
}

extension Stupslers: Equatable {
}
