//
//  DetailModel.swift
//  MyNews
//
//  Created by Svyat Chaplin on 03.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

class DetailModel {
    
    private var storageManager: StorageManager
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    func saveNewsData(_ data: Articles) {
        storageManager.saveNewsData(data)
    }

    func getData() -> [Articles]? {
        storageManager.getData()
    }
    
}
