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

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var webView: WKWebView!

    var startUrl: String?
    var newsData: Results?

    var detailModel: DetailModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        favoriteButton.layer.cornerRadius = 10
        if newsData == nil {
            favoriteButton.isEnabled = false
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

    @IBAction func addToFavoriteButton(_ sender: UIButton) {
        guard let data = newsData else { return }
        favoriteButton.isEnabled = false
        detailModel.saveNewsData(data)
    }
}
