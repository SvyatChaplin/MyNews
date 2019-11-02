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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!

    var startUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlString = startUrl,
        let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }

}
