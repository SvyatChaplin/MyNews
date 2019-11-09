//
//  DetailViewController.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var webView: WKWebView!

    var startUrl: String?
    var googleNews: Articles?

    var detailModel: DetailModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        setupBindings()
    }

//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        indicator.startAnimating()
//    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }

    private func setupBindings() {
        webView.navigationDelegate = self
        favoriteButton.layer.cornerRadius = 10
        if googleNews == nil {
            favoriteButton.isEnabled = false
            guard let urlString = startUrl,
                let url = URL(string: urlString) else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
            webView.load(urlRequest)
        } else {
            guard let urlString = googleNews?.url,
                let url = URL(string: urlString) else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
            webView.load(urlRequest)
        }
    }
    
    @IBAction func addToFavoriteButton(_ sender: UIButton) {
        guard let data = googleNews else { return }
        favoriteButton.isEnabled = false
        detailModel.saveNewsData(data)
    }
}
