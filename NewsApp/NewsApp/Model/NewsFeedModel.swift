//
//  NewsFeedModel.swift
//  NewsApp
//
//  Created by Rajashree on 31/3/21.
//

import Foundation

struct NewsFeedModel: Decodable {
    let title: String
    let date: String
    let image: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case title, date = "pubDate", image = "thumbnail", content
    }
}
