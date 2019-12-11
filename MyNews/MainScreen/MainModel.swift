//
//  MainModel.swift
//  MyNews
//
//  Created by Svyat Chaplin on 03.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

class MainModel {
    
    var didReceiveAnError: ((Error?) -> Void)?
    var didUpdateGoogleData: ((GoogleNews?) -> Void)?
    
    private var storageManager: StorageManager
    private let networkingManager: NetworkingManager
    
    init(storageManager: StorageManager, networkingManager: NetworkingManager) {
        self.storageManager = storageManager
        self.networkingManager = networkingManager
    }


    func fetchGoogleNews(_ segmentIndex: Int) {
        var category: Category = .none
        switch segmentIndex {
        case 0:
            category = .none
        case 1:
            category = .sports
        case 2:
            category = .technology
        default:
            category = .business
        }

        if networkingManager.checkConnection() {
            networkingManager.fetchGoogleNews(category: category) { [weak self] (googleNews, error) in
                guard let self = self else { return }
                if googleNews == nil {
                    self.didReceiveAnError?(error)
                    return
                }
                self.didUpdateGoogleData?(googleNews)
            }
        } else {
            self.didReceiveAnError?(nil)
        }
    }

    func detailModelForGoogle(for data: [Articles]) -> DetailModel {
        return DetailModel(storageManager: storageManager)
    }
    
}
