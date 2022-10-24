//
//  Session.swift
//  RedditDemo
//
//  Created by Israrul on 10/23/22.
//  Copyright © 2022 Israrul. All rights reserved.
//

import Foundation

class Session {
    static let session = Session()
    
    final let urlComponents: URLComponents = {
        var _urlComponenets = URLComponents()
        _urlComponenets.scheme = "http"
        _urlComponenets.host = "reddit.com"
        return _urlComponenets
    }()
    
    func getListingsFor(sub: SubReddits, listing: ListingTypes, paginationIndex: String?, closure: @escaping ClosureTypes.ListingResponseClosure) {
        var _urlComponents = urlComponents
        _urlComponents.path = sub.rawValue + listing.rawValue
        
        if let pagination = paginationIndex {
            _urlComponents.queryItems = [
                URLQueryItem(name: "after", value: pagination)
            ]
        }
        
        let task = URLSession.shared.dataTask(with: _urlComponents.url!) {[closure] (data, response, error) in
            guard let data = data else { return }
            
            let responseObject = try? JSONDecoder().decode(ListingResponseModel.self, from: data)
            closure(responseObject)
        }
        
        task.resume()
    }
    
    func getCommentsFor(sub: SubReddits, articleID: String, paginationIndex: String?, closure: @escaping ClosureTypes.ListingsResponseClosure) {
        var _urlComponents = urlComponents
        _urlComponents.path = sub.rawValue + "comments/\(articleID).json"
        
        if let pagination = paginationIndex {
            _urlComponents.queryItems = [
                URLQueryItem(name: "after", value: pagination)
            ]
        }
        let task = URLSession.shared.dataTask(with: _urlComponents.url!) {[closure] (data, response, error) in
            guard let data = data else { return }
            do {
                let responseObject = try JSONDecoder().decode([ListingResponseModel].self, from: data)
                closure(responseObject)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func downloadDataForImage(from url: URL, closure: @escaping ClosureTypes.LoadImageDataClosure) {
        let task = URLSession.shared.dataTask(with: url) {[closure] (data, response, error) in
            guard let data = data, error == nil else {return}
            closure(data)
        }
        task.resume()
    }
    
}
