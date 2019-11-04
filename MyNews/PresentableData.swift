//
//  PresentableData.swift
//  MyNews
//
//  Created by Svyat Chaplin on 04.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

struct PresentableData {
    
    let url: String
    let title: String
    let abstract: String
    
}

extension PresentableData {
    
    init(newsData: Results) {
        self.abstract = newsData.abstract
        self.title = newsData.title
        self.url = newsData.url
    }
    
    init(savedNewsData: SavedNewsData) {
        self.abstract = savedNewsData.abstract ?? "Sorry, but something went wrong"
        self.title = savedNewsData.title ?? "Error"
        self.url = savedNewsData.url ?? "Error"
    }
    
}
