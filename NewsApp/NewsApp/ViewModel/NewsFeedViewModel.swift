//
//  NewsFeedViewModel.swift
//  NewsApp
//
//  Created by AADM504 on 31/3/21.
//

import Foundation

class NewsFeedViewModel {
    var newsList: [NewsFeedModel] = []
    
    init() {
        let service = NewsFeedViewService()
        service.getNewsList() { [weak self] (data, message) in
            guard let list = data else { return }
            self?.newsList = list
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ListUpdated"), object: self?.newsList)
        }
    }
}
