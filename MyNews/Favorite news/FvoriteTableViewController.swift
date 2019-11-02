//
//  FvoriteTableViewController.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var newsData: NewsData?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.backView.layer.cornerRadius = 10
        cell.titleLabel.text = "Title"
        cell.newsDetailsLabel.text = "Details"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detailVC = segue.destination as! DetailViewController
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
//        if segue.identifier == "???" {
//            detailVC.startUrl = newsData?.results[indexPath.row].url
//        }
    }


}
