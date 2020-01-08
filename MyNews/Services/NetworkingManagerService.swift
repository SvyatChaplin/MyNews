//
//  NetworkingManager.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation
import Alamofire

enum Category {
    case none
    case business
    case technology
    case sports
    case entertainment
}

class NetworkingManagerService: NetworkingManager {

    private let googleApiKey: String = "&apiKey=279321c7e0e140a4ac169234e6b6d21a"
    private let baseURL: String = "https://newsapi.org/v2/top-headlines?country=us"

    func checkConnection() -> Bool {
        let connectionStatus = NetworkReachabilityManager(
            host: "https://www.google.com/")?.isReachable
        return connectionStatus!
    }

    func fetchGoogleNews(category: Category, completionHandler: @escaping (_ presentableData: GoogleNews?, _ error: Error?) -> Void) {

        var categoryOfNews: String = ""

        switch category {
        case .none:
            categoryOfNews = ""
        case .business:
            categoryOfNews = "&category=business"
        case .sports:
            categoryOfNews = "&category=sports"
        case .entertainment:
            categoryOfNews = "&category=entertainment"
        case .technology:
            categoryOfNews = "&category=technology"
        }

        let urlString = baseURL + categoryOfNews + googleApiKey
        
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url, method: .get)
            .responseJSON { (response) in
                DispatchQueue.main.async {
                    if response.data != nil {
                        guard let data = response.data else { return }
                        do {
                            let googleNews = try JSONDecoder().decode(GoogleNews.self, from: data)
                            completionHandler(googleNews, nil)
                        } catch {
                            print(error)
                            completionHandler(nil, error)
                        }
                    } else {
                        print(response.error?.localizedDescription ?? "Something wrong")
                        completionHandler(nil, response.error)
                    }
                }
        }
    }
    
}
