//
//  FvoriteTableViewController.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    private var storageManagerService = StorageManagerService()
    private var newsData: [SavedNewsData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        newsData = storageManagerService.getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsData = storageManagerService.getData()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.backView.layer.cornerRadius = 10
        cell.titleLabel.text = newsData?[indexPath.row].title
        cell.newsDetailsLabel.text = newsData?[indexPath.row].abstract
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            storageManagerService.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "saved" {
            detailVC.startUrl = newsData?[indexPath.row].url
        }
    }


}
