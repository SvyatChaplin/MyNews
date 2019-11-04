//
//  NewsData.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation

struct NewsData: Decodable {

    let results: [Results]

}

struct Results: Decodable {

    let url: String
    let title: String
    let abstract: String
    
}
