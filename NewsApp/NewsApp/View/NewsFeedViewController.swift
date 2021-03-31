//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by AADM504 on 31/3/21.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NewsFeedViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewModel()
    }
    
    private func setUpViewModel() {
        viewModel = NewsFeedViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable), name: NSNotification.Name("ListUpdated"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableId = "NewsFeedCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableId) as? NewsFeedTableViewCell else { preconditionFailure("Expected cell") }
        cell.configure(with: viewModel.newsList[indexPath.row])
        return cell
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - Private methods

extension NewsFeedViewController {
    @objc private func refreshTable() {
        self.tableView.reloadData()
    }
}
