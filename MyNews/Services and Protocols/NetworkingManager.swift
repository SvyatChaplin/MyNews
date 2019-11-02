//
//  NetworkingManager.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation
import Alamofire

enum NewsCategory {
    case shared
    case viewed
    case mailed
}

class NetworkingManagerService {

    func fetchData(category: NewsCategory ,complitionHandler: @escaping (_ news: NewsData?) -> Void) {
        let urlString: String?
        switch category {
        case .mailed:
            urlString = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=p2tkAeA6jop4Fn9JwtABNyrxGf2MrWgI"
        case .shared:
            urlString = "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json?api-key=p2tkAeA6jop4Fn9JwtABNyrxGf2MrWgI"
        case .viewed:
            urlString = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=p2tkAeA6jop4Fn9JwtABNyrxGf2MrWgI"
        }
        guard let safeURL = urlString,
        let url = URL(string: safeURL) else { return }
        AF.request(url, method: .get).responseJSON { (response) in
            DispatchQueue.main.async {
                if response.data != nil {
                    guard let data = response.data else { return }
                    do {
                        let myResponse = try JSONDecoder().decode(NewsData.self, from: data)
                        complitionHandler(myResponse)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print(response.error?.localizedDescription ?? "Something wrong")
                    complitionHandler(nil)
                }
            }
        }
    }

}
