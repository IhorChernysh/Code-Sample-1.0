//
//  NewMessage.swift
//  p153-ios
//
//  Created by Игорь Черныш on 26.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

enum MessageContentType: String {
    case text = "TEXT"
    case gif = "GIF"
    case stupsel = "STUPSEL"
    case image = "IMAGE"
}

struct NewMessage {
    var chatID: String
    var content: MessageContent
    var contentType: MessageContentType
    
    enum CodingKeys: String, CodingKey {
        case chatID = "chat_id"
        case content
        case contentType = "content_type"
    }
    
    // MARK: - Methods
    
    func createJSON() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict[CodingKeys.chatID.rawValue] = self.chatID
        switch contentType {
        case .text:
            dict[CodingKeys.content.rawValue] = ["text": self.content.text]
        case .gif,
             .stupsel,
             .image:
            dict[CodingKeys.content.rawValue] = ["id": self.content.id]
        }
        dict[CodingKeys.contentType.rawValue] = self.contentType.rawValue
        
        return dict
    }
}
