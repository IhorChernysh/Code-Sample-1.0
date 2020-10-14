//
//  MessagesAPI.swift
//  p153-ios
//
//  Created by Игорь Черныш on 25.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation
import Alamofire

enum MessagesAPI {
    case fetchAllStupslers
    case sendMessage(NewMessage)
}

extension MessagesAPI: TargetEndpoint {
    var path: String {
        switch self {
        case .fetchAllStupslers:
            return "/stupsels/types"
        case .sendMessage:
            return "/chats"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchAllStupslers:
            return .get
        case .sendMessage:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .fetchAllStupslers:
            return ["v": 2]
        case .sendMessage(let newMessage):
            return newMessage.createJSON()
        }
    }
    
    var header: HTTPHeader? {
        switch self {
        case .fetchAllStupslers,
             .sendMessage:
            let accessToken = UserDefaults.standard.value(forKey: UserDefaultsKeys.userAccessToken.rawValue) as? String
            let defaultInvalidToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay1wcHU2OUBzaW5nbGVkZS1kYWUxNC5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInN1YiI6ImZpcmViYXNlLWFkbWluc2RrLXBwdTY5QHNpbmdsZWRlLWRhZTE0LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwiYXVkIjoiaHR0cHM6XC9cL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbVwvZ29vZ2xlLmlkZW50aXR5LmlkZW50aXR5dG9vbGtpdC52MS5JZGVudGl0eVRvb2xraXQiLCJpYXQiOjE1OTI1NjQxNTQsImV4cCI6MTU5MjU2Nzc1NCwidWlkIjoic25nbF8xMzY5ODE2MCIsImdyYW50X3R5cGUiOiJwYXNzd29yZCIsInNjb3BlIjoic2luZ2xlX3dlYiJ9.ELUBInL9m_cRmqAyD-D3rSoXE-xlbFDIcF_Y11vd9ZV9doYWki-VjVRI8j5S_oknEfX5RRwWT4iuKFmROcaxt_7VxDwGK9tugnDBUKdjJpdTWkmynQ8oK0ayE4sqJ7q0H2QXjCv96O4oLzF9NYIHhq_hsWqXV67fctr06QhqX3ur8JKsLEo39Y8XbF84BzWl1Xzgu7abfy7mVOXw-1pGWxphUJUxtedrvDog7WFvL5ZFb-U_O6nse_-dF_3Q3K95zLiUSVR9SqjLs921guGi6crgGsbXcB2M-VEld8I8H9Gk_cJHYPCpnQ7DxadQ7B8E1AjyIaS6MLdWITI5FJjPi"
            return HTTPHeader(name: "Authorization", value: "Bearer \(accessToken ?? defaultInvalidToken)")
        }
    }
}
