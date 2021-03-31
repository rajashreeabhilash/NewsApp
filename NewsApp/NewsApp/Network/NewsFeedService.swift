//
//  NewsFeedService.swift
//  NewsApp
//
//  Created by Rajashree on 31/3/21.
//

import Foundation

class NewsFeedViewService: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    var baseUrlString = "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
    var dataTask : URLSessionDataTask?
    var errorMessage = ""
    
    func getNewsList(completion: @escaping ([NewsFeedModel]?, String) -> Void) {
        //Cancel any task if it was running
        dataTask?.cancel()
        
        if let urlComponents = URLComponents(string: baseUrlString) {
            guard let url = urlComponents.url else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let defaultUrlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
            dataTask = defaultUrlSession.dataTask(with: request) {[weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                
                if let error = error {
                    self?.errorMessage += "Error retrieving info:" + error.localizedDescription
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    //Form the model class on successful server response
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.ddMMYYYY)
                    if let list = try? decoder.decode(NewsFeedResponse.self, from: data) {
                        completion(list.items, self?.errorMessage ?? "")
                    } else {
                        completion([], self?.errorMessage ?? "")
                    }
                }
            }
            
            //Start the data task
            dataTask?.resume()
        }
    }

    //MARK: - URLSessionData Delegate
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        completionHandler(URLSession.ResponseDisposition.allow)
    }
}

// MARK: - Dateformatter

extension DateFormatter {
  static let ddMMYYYY: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy hh:mm a"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
