//
//  NewsCvCellProtocol.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation

public protocol NewsCvCellProtocol {
    var image: String { get set }
    var title: String { get set }
    var author: String { get set }
    var details: String { get set }
    var isViewAuthorHidden: Bool { get }
}

class NewsCvCellImplementation : NewsCvCellProtocol {
    var image: String
    var title: String
    var author: String
    var details: String
    var isViewAuthorHidden: Bool { author == "" }
    
    init(_ aricle: ArticleModel) {
        self.image = aricle.urlToImage ?? ""
        self.title = aricle.title ?? ""
        self.author = aricle.author ?? ""
        self.details = aricle.description ?? ""
    }
}
