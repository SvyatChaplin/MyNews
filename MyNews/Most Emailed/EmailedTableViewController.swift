//
//  EmailedTableViewController.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit

class EmailedTableViewController: UITableViewController {

    var networkingManager = NetworkingManagerService()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkingManager.firstRequest()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.backView.layer.cornerRadius = 10

        cell.titleLabel.text = "Last Major Nuclear Arms Pact Could Expire With No Replacement, Russia Says"

        cell.newsDetailsLabel.text = "The treaty, disliked by President Trump, will run out in 14 months — and there is too little time to hammer out a new one, a Russian official said."

        // Configure the cell...

        return cell
    }

}
