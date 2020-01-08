//
//  GoogleNews.swift
//  MyNews
//
//  Created by Svyat Chaplin on 07.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

struct GoogleNews: Decodable {

    let articles: [Articles]

}

struct Articles: Decodable {

    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    
}
