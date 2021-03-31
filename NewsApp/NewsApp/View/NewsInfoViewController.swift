//
//  NewsInfoViewController.swift
//  NewsApp
//
//  Created by Rajashree on 1/4/21.
//

import UIKit

class NewsInfoViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var viewModel: NewsInfoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpViews()
    }
    
    func setUpViewModel(with item: NewsFeedModel) {
        viewModel = NewsInfoViewModel(with: item)
    }
    
    private func setUpViews() {
        nameLabel.text = viewModel.newsArticle.title
        dateLabel.text = viewModel.newsArticle.date
        contentLabel.text = viewModel.newsArticle.content
    }
}
