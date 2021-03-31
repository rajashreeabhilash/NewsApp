//
//  NewsFeedResponse.swift
//  NewsApp
//
//  Created by AADM504 on 31/3/21.
//

import Foundation

struct NewsFeedResponse: Decodable {
    let items: [NewsFeedModel]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([NewsFeedModel].self, forKey: .items)
    }
}
