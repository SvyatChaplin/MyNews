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
    var didUpdateData: (([PresentableData]?) -> Void)?
    
    private var storageManager: StorageManager
    private let networkingManager: NetworkingManager
    
    init(storageManager: StorageManager, networkingManager: NetworkingManager) {
        self.storageManager = storageManager
        self.networkingManager = networkingManager
    }
    
    func fetchData(_ segmentIndex: Int) {
        var category: NewsCategory = .mailed
        switch segmentIndex {
        case 0:
            category = .mailed
        case 1:
            category = .viewed
        case 2:
            category = .shared
        default:
            return
        }
        if networkingManager.checkConnection() {
            networkingManager.fetchData(
            category: category) { [weak self] (newsData, error) in
                guard let self = self else { return }
                if newsData == nil {
                    self.didReceiveAnError?(error)
                    return
                }
                self.didUpdateData?(newsData)
            }
        } else {
            self.didReceiveAnError?(nil)
        }
    }
    
    func detailModel(for data: [PresentableData]) -> DetailModel {
        return DetailModel(storageManager: storageManager)
    }
    
}
