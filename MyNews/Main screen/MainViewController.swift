//
//  MainViewController.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    private var networkingManager = NetworkingManagerService()
    private var storageManager = StorageManagerService()
    private var newsData: NewsData?
    private let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        myRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        myRefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(myRefreshControl)
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
    }

    // MARK: - Methods to refresh data

    @objc func refresh(_ sender: Any) {
        fetchData()
    }

    private func fetchData() {

        var category: NewsCategory = .mailed

        switch segmentController.selectedSegmentIndex {
        case 0:
            category = .mailed
        case 1:
            category = .viewed
        case 2:
            category = .shared
        default:
            return
        }
        
        if networkingManager.checkConnection() {
        networkingManager.fetchData(category: category) { [weak self] (data) in
            if data == nil {
                self?.alert()
            }
            self?.newsData = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.myRefreshControl.endRefreshing()
            }
        }
        } else {
            self.alert()
        }
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData?.results.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.backView.layer.cornerRadius = 10
        cell.titleLabel.text = newsData?.results[indexPath.row].title
        cell.newsDetailsLabel.text = newsData?.results[indexPath.row].abstract
        return cell
    }

    // MARK: - Navigation, IBActions and alerts

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "load" {
            detailVC.newsData = newsData?.results[indexPath.row]
            detailVC.objectIndex = indexPath.row
        }
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        fetchData()
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Connection error",
                                      message: "You can use Favorite News offline",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.myRefreshControl.endRefreshing()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
