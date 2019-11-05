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

    func setupCell(presentableData: [PresentableData]?, index: Int) {
        self.backView.layer.cornerRadius = 10
        self.titleLabel.text = presentableData?[index].title
        self.newsDetailsLabel.text = presentableData?[index].abstract
    }
    
}
