//
//  NetworkingManager.swift
//  MyNews
//
//  Created by Svyat Chaplin on 03.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

protocol NetworkingManager {

    func checkConnection() -> Bool
    func fetchData(
    category: NewsCategory,
    completionHandler: @escaping (_ presentableData: [PresentableData]?, _ error: Error?) -> Void)

}
