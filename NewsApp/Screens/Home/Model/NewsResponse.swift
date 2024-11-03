//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleModel]?
    let code: String?
    let message: String?

}

struct ArticleModel: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init(author: String? = nil, title: String? = nil, description: String? = nil, url: String? = nil, urlToImage: String? = nil, publishedAt: String? = nil, content: String? = nil) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
}
