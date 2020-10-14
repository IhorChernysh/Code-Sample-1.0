//
//  StupselnViewModel.swift
//  p153-ios
//
//  Created by ihor-ios on 10.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

class StupselnViewModel {
    
    private let disposeBag = DisposeBag()
    let messageNetworkService = MessagesNetworkService()
    
    var stupselnSectionRelay = BehaviorRelay<[StupselnSection]>(value: [StupselnSection(headerImage: UIImage(), title: "", description: "", stupselnItems: [])])
    var allStupslers: [Stupslers] = []
    var allDefaultInactiveStupslers: [Stupslers] = []
    var selectedStupselnRelay = BehaviorRelay<Stupslers?>(value: nil)
    var allStupslersSubject = BehaviorSubject<[Stupslers]>(value: [])
    
    var selectedFeed: Feed?
    var didPostStupslerSubject = PublishSubject<Void>()
    
    // MARK: - Methods
    
    func fetchAllStupslers() {
        // check if no internet
        if !Connectivity.isConnectedToInternet {
            let networkError = APIError.networkIssue.toNSError() as Error
            didPostStupslerSubject.onError(networkError)
            return
        }
        
        messageNetworkService
        .fetchAllStupseln()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] stupslers in
                self?.allStupslersSubject.onNext(stupslers)
            }, onError: { [weak self] error in
                self?.allStupslersSubject.onError(error)
            })
        .disposed(by: disposeBag)
    }
    
    func updateSelectesStupsler() {
        
    }
    
    func sendStupsler() {
        var selectedFeedUserID = selectedFeed?.profile?.profileID
        if selectedFeedUserID == nil {
            selectedFeedUserID = selectedFeed?.profileID
        }
        let selectedStupseln = selectedStupselnRelay.value
        let stupslerToSend = NewMessage(chatID: selectedFeedUserID ?? "", content: .init(id: selectedStupseln?.coinActionID, text: nil), contentType: .stupsel)
        messageNetworkService
            .sendNewMessage(stupslerToSend)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.didPostStupslerSubject.onNext(())
                }, onError: { [weak self] error in
                    self?.didPostStupslerSubject.onError(error)
            })
            .disposed(by: disposeBag)
    }
}
