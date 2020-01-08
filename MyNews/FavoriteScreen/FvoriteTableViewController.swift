//
//  FvoriteTableViewController.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    var favoriteModel: FavoriteModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteModel?.getNews()?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        guard let newsInfo = favoriteModel?.getNews()?[indexPath.row] else { return cell }
        cell.setupCellForGoogle(googleNews: newsInfo)
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteModel?.removeElement(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let detailVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == "saved" else {
                return
        }
        detailVC.startUrl = favoriteModel?.getNews()?[indexPath.row].url
    }

}
