//
//  NewsInfoViewModel.swift
//  NewsApp
//
//  Created by Rajashree on 1/4/21.
//

import Foundation

class NewsInfoViewModel {
    let newsArticle: NewsFeedModel
    
    init(with item: NewsFeedModel) {
        self.newsArticle = item
    }
}
