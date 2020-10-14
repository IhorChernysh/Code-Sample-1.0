//
//  MessagesNetworkService.swift
//  p153-ios
//
//  Created by Игорь Черныш on 25.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class MessagesNetworkService {
    
    // MARK: - Methods
    
    func fetchAllStupseln() -> Observable<[Stupslers]> {
        return Observable.create { observer -> Disposable in
            let endpoint = MessagesAPI.fetchAllStupslers
            if let url = URL(string: "\(baseURL)\(endpoint.path)") {
                AF.request(url,
                           method: endpoint.method,
                           parameters: endpoint.parameters,
                           headers: [endpoint.header!])
                    .validate()
                    .responseJSON { dataResponse in
                        switch dataResponse.result {
                        case .success:
                            guard let data = dataResponse.data else {
                                observer.onError(dataResponse.error ?? NSError())
                                return
                            }
                            do {
                                let allStupslers = try JSONDecoder().decode(StupslerType.self, from: data)
                                let stupslers = allStupslers.stupselTypes
                                observer.onNext(stupslers)
                            } catch {
                                observer.onError(APIError.codableIssue.toNSError())
                            }
                        case .failure:
                            let errorType = self.checkResponseStatusCode(response: dataResponse)
                            observer.onError(errorType.toNSError())
                        }
                }
            }
            return Disposables.create()
        }
    }
    
    func sendNewMessage(_ newMessage: NewMessage) -> Observable<Bool> {
        let endpoint = MessagesAPI.sendMessage(newMessage)
        return Observable.create { observer in
            return Disposables.create()
        }
    }
    
    private func checkResponseStatusCode(response: AFDataResponse<Any>) -> APIError {
        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 401, 400:
                return .invalidToken
            default:
                if let _ = response.error {
                    return .badResponse
                }
            }
        }
        return .badResponse
    }
}
