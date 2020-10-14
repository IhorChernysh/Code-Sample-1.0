//
//  AFDataResponse+Ext.swift
//  p153-ios
//
//  Created by Игорь Черныш on 27.07.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension AFDataResponse {
    func checkResponseStatusCode() -> APIError {
        if let statusCode = self.response?.statusCode {
            switch statusCode {
            case 401, 400:
                return .invalidToken
            default:
                if let _ = self.error {
                    return .badResponse
                }
            }
        }
        return .badResponse
    }
    
    func checkErrorType(errorType: APIError, data: Data) -> Error {
        if errorType == .invalidToken {
            return errorType.toNSError()
        } else {
            do {
                let responseError = try JSONDecoder().decode(ResponseError.self, from: data)
                if let errorDescription = responseError.errorDescription {
                    return responseError.toNSError(description: errorDescription)
                } else {
                    return errorType.toNSError()
                }
            } catch {
                return error
            }
        }
    }
}
