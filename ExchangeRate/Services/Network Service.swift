//
//  Network Service.swift
//  ExchangeRate
//
//  Created by Aleksandr Svetilov on 10.09.2020.
//  Copyright © 2020 Aleksandr Svetilov. All rights reserved.
//

import Foundation

protocol NetworkService {
    func getUrlWithQueryItems(url: URL, queryItems: [URLQueryItem]) -> URL
    func getDataFromUrl(_ url: URL, completion: @escaping (Data) -> Void)
}

class DefaultNetworkService: NetworkService {
    
    func getUrlWithQueryItems(url: URL, queryItems: [URLQueryItem]) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        return components!.url!
    }
    
    func getDataFromUrl(_ url: URL, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data)
            }
        }
        task.resume()
    }
}
