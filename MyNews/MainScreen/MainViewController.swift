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
    
    private var presentableData: [PresentableData]?
    private let myRefreshControl = UIRefreshControl()
    
    var mainModel: MainModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupRefreshControl()
        mainModel.fetchData(segmentController.selectedSegmentIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainModel.fetchData(segmentController.selectedSegmentIndex)
    }
    
    // MARK: - Methods to refresh data
    
    private func setupRefreshControl() {
        myRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        myRefreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(myRefreshControl)
    }
    
    @objc private func refresh(_ sender: Any) {
        mainModel.fetchData(segmentController.selectedSegmentIndex)
    }
    
    private func setupBindings() {
        mainModel.didReceiveAnError = { [weak self] error in
            self?.alert(error)
        }
        mainModel.didUpdateData = { [weak self] newsData in
            self?.presentableData = newsData
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.myRefreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentableData?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        guard let newsInfo = presentableData?[indexPath.row] else { return cell }
        cell.setupCell(newsInfo: newsInfo)
        return cell
    }
    
    // MARK: - Navigation, IBActions and alerts
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "load" {
            guard let presentableData = presentableData else { return }
            detailVC.detailModel = mainModel.detailModel(for: presentableData)
            detailVC.newsData = presentableData[indexPath.row]
        }
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        mainModel.fetchData(segmentController.selectedSegmentIndex)
    }
    
    private func alert(_ error: Error?) {
        let alert = UIAlertController(title: "Connection error",
                                      message: error?.localizedDescription ?? "No internet connection. You can use Favorite screen offline",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.myRefreshControl.endRefreshing()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
