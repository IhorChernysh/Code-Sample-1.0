//
//  ResponseError.swift
//  p153-ios
//
//  Created by ihor-ios on 29.05.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

enum ResponseErrorType {
    case nickNameInUse
    case sixCharactersRequired
    case other
    
    var title: String {
        switch self {
        case .nickNameInUse:
            return "Benutzername bereits vergeben"
        case .sixCharactersRequired:
            return "Dein Benutzername muss mind. 6 Zeichen lang sein"
        case .other:
            return "Ungültiger Benutzername"
        }
    }
}

struct ResponseError: Decodable {
    var errorDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case errorDescription = "error_description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.errorDescription = try? container.decode(String.self, forKey: .errorDescription)
    }
    
    // MARK: - Methods
    
    func toNSError(description: String) -> NSError {
        let userInfo: [String: Any] = [NSLocalizedDescriptionKey: description]
        return NSError(domain: "", code: -000, userInfo: userInfo)
    }
}
