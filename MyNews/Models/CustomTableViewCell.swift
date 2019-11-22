//
//  CustomTableViewCell.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsDetailsLabel: UILabel!

    func setupCellForGoogle(googleNews: Articles) {
        
        self.backView.layer.cornerRadius = 10
        self.viewForImage.layer.cornerRadius = 10
        self.viewForImage.clipsToBounds = true
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor.black.cgColor
        self.backView.layer.shadowOffset = .zero
        self.backView.layer.shadowOpacity = 0.3
        self.backView.layer.shadowRadius = 7
        if let urlToImage = googleNews.urlToImage {
            let url = URL(string: urlToImage)
            self.newsImageView.kf.setImage(with: url)
        } else {
            self.newsImageView.image = #imageLiteral(resourceName: "error_image")
        }
        self.titleLabel.text = googleNews.title
        self.newsDetailsLabel.text = googleNews.description
    }
}
