//
//  StorageManager.swift
//  MyNews
//
//  Created by Svyat Chaplin on 03.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

protocol StorageManager {
    
    func saveNewsData(_ data: Results)
    func getData() -> [PresentableData]?
    func removeObject(at index: Int)
    
}
