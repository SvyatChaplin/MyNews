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

    var detailModel: DetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        webView.navigationDelegate = self
        initialSetup()
    }

    private func initialSetup() {
        favoriteButton.layer.cornerRadius = 10
        if googleNews == nil {
            favoriteButton.isEnabled = false
            setupWebView(startUrl)
        } else {
            guard let results = detailModel?.getData() else { return }
            for result in results {
                if result.url == googleNews?.url {
                    favoriteButton.isEnabled = false
                }
            }
            setupWebView(googleNews?.url)
        }
    }

    private func setupWebView(_ urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        webView.load(urlRequest)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
    @IBAction func addToFavoriteButton(_ sender: UIButton) {
        guard let data = googleNews else { return }
        favoriteButton.isEnabled = false
        detailModel?.saveNewsData(data)
    }
}
