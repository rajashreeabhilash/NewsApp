//
//  NewsFeedTableViewCell.swift
//  NewsApp
//
//  Created by Rajashree on 31/3/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class NewsFeedTableViewCell: UITableViewCell {
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func configure(with item:NewsFeedModel) {
        titleLabel.text = item.title
        dateLabel.text = item.date
        newsImage.imageFromServerURL(item.image, placeHolder: UIImage(named: "placeholderImage"))
    }
}

// MARK: UIImageView extension

extension UIImageView {
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = nil
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
