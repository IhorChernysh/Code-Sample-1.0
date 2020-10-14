//
//  StupslerType.swift
//  p153-ios
//
//  Created by Игорь Черныш on 25.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

struct StupslerType: Decodable {
    var stupselTypes: [Stupslers]
    
    enum CodingKeys: String, CodingKey {
        case stupselTypes = "stupsel_types"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stupselTypes = try container.decode([Stupslers].self, forKey: .stupselTypes)
    }
}
