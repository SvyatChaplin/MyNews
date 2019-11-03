//
//  DetailViewController.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    private var storageManager = StorageManagerService()

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!

    var startUrl: String?
    var newsData: Results?
    var objectIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteButton.layer.cornerRadius = 25
        if newsData == nil {
            guard let urlString = startUrl,
                let url = URL(string: urlString) else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
            webView.load(urlRequest)
        } else {
            guard let urlString = newsData?.url,
                let url = URL(string: urlString) else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
            webView.load(urlRequest)
        }
    }

    @IBAction func addOrRemoveButton(_ sender: UIButton) {
        guard let data = newsData else { return }
        storageManager.saveNewsData(data)
    }
}
