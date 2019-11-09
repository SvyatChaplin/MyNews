//
//  FavoriteModel.swift
//  MyNews
//
//  Created by Svyat Chaplin on 03.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

class FavoriteModel {

    private var storageManager: StorageManager

    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }

    func getNews() -> [Articles]? {
        return storageManager.getData()
    }

    func removeElement(at index: Int) {
        storageManager.removeObject(at: index)
    }

}
