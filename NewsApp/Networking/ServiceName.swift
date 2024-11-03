//
//  ServiceName.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation

enum ServiceName {
    case everyThing(NewsRequestModel)
        
    func url() -> URL? {
        let baseURL = "https://newsapi.org/"
        let apiKey = "2c911c2e77294fcda47b4b98a82fcceb"
        
        
        switch self {
        case .everyThing(let model):
            var components = URLComponents(string: baseURL + "v2/everything")
            components?.queryItems = [
                URLQueryItem(name: "sortBy", value: "publishedAt"),
                URLQueryItem(name: "q", value: model.search),
                URLQueryItem(name: "from", value: model.date),
                URLQueryItem(name: "apiKey", value: apiKey)
            ]
            return components?.url
        }
        
        
    }
    
}
