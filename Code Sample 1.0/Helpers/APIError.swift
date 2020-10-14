//
//  APIError.swift
//  p153-ios
//
//  Created by ihor-ios on 16.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

enum APIError {
    case invalidInput
    case badResponse
    case networkIssue
    case invalidToken
    case codableIssue
    
    var descriptionForError: String {
        switch self {
        case .invalidInput:
            return "Input info is invalid"
        case .badResponse:
            return "Bad response"
        case .networkIssue:
            return "Es besteht anscheinend keine Verbindung zum Internet."
        case .invalidToken:
            return "Invalid token"
        case .codableIssue:
            return "Can't encode or decode data"
        }
    }
    
    func toNSError() -> NSError {
        let userInfo: [String: Any] = [NSLocalizedDescriptionKey: self.descriptionForError]
        switch self {
        case .invalidInput:
            return NSError(domain: "", code: -1, userInfo: userInfo)
        case .badResponse:
            return NSError(domain: "", code: -2, userInfo: userInfo)
        case .networkIssue:
            return NSError(domain: "", code: -3, userInfo: userInfo)
        case .invalidToken:
            return NSError(domain: "", code: -4, userInfo: userInfo)
        case .codableIssue:
            return NSError(domain: "", code: -5, userInfo: userInfo)
        }
    }
}
