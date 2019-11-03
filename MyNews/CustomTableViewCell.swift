//
//  CustomTableViewCell.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsDetailsLabel: UILabel!

    func setupCell(_ cell: CustomTableViewCell, _ newsData: NewsData?, _ indexPath: IndexPath) -> UITableViewCell {
        cell.backView.layer.cornerRadius = 10
        cell.titleLabel.text = newsData?.results[indexPath.row].title
        cell.newsDetailsLabel.text = newsData?.results[indexPath.row].abstract
        return cell
    }
    
}
