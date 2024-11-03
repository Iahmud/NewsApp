//
//  ArticleRepository.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation
import Combine
import CoreData

class ArticleRepository {
    static let shared = ArticleRepository()
    private let context = CoreDataManager.shared.context
    func saveArticle(_ articleModel: ArticleModel) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(NSError(domain: "ArticleRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "Self is nil"])))
                return
            }
            
            if self.articleExists(withURL: articleModel.title ?? "") {
                promise(.success(false))
                return
            }
            let article = Article(context: self.context)
            article.author = articleModel.author
            article.title = articleModel.title
            article.articleDescription = articleModel.description
            article.url = articleModel.url
            article.urlToImage = articleModel.urlToImage
            article.publishedAt = articleModel.publishedAt
            article.content = articleModel.content
            do {
                try self.context.save()
                promise(.success(true))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
        
    private func articleExists(withURL title: String) -> Bool {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            return false
        }
    }
    
    func fetchArticles() -> [ArticleModel] {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest).map {
                ArticleModel(author: $0.author, title: $0.title, description: $0.articleDescription, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)
            }
        } catch {
            return []
        }
    }
    
    func fetchArticles() -> AnyPublisher<[ArticleModel], Error> {
        return Future<[ArticleModel], Error> { [weak self] promise in
            guard let self = self else {
                promise(.failure(NSError(domain: "ArticleRepository", code: -1, userInfo: [NSLocalizedDescriptionKey: "Self is nil"])))
                return
            }
            
            let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
            
            do {
                let articles = try self.context.fetch(fetchRequest).map {
                    ArticleModel(author: $0.author, title: $0.title, description: $0.articleDescription, url: $0.url, urlToImage: $0.urlToImage, publishedAt: $0.publishedAt, content: $0.content)
                }
                promise(.success(articles))
            } catch {
                promise(.failure(error)) 
            }
        }
        .eraseToAnyPublisher()
    }

}
