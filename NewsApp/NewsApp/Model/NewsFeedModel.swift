//
//  NewsFeedModel.swift
//  NewsApp
//
//  Created by AADM504 on 31/3/21.
//

import Foundation

struct NewsFeedModel: Decodable {
    let title: String
    let date: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title, date = "pubDate", image = "thumbnail"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        date = try container.decode(String.self, forKey: .date)
        image = try container.decode(String.self, forKey: .image)
    }
}
