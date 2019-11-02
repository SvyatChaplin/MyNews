//
//  NetworkingManager.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingManagerService {

    func firstRequest() {
        AF.request("https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=p2tkAeA6jop4Fn9JwtABNyrxGf2MrWgI")
            .response { response in
            print(response)
        }
    }
}
