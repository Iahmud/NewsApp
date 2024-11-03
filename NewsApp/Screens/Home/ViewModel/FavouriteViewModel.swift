//
//  FavouriteViewModel.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation
import Combine

class FavouriteViewModel: HomeViewModelProtocol {
    var title = "Favourite"
    var isFilterHidden = true
    
    var updateView = PassthroughSubject<Bool, Never>()
    var loading = PassthroughSubject<Bool, Never>()
    var showError = PassthroughSubject<String, Never>()

    private var articles: [ArticleModel] = []
       
    private var cancellables = Set<AnyCancellable>()
 
    var numberOfRowsInSection: Int { articles.count }

    func fetchData() {
        getNews()
    }

    
}

//MARK: - Collection View
extension FavouriteViewModel {
    func cellForItemAt(_ index:Int) -> NewsCvCellProtocol {
        NewsCvCellImplementation( articles[index] )
    }
    
    func getSelectedCell(_ index:Int) -> ArticleModel {
         articles[index]
    }
}

//MARK: - Api Request


extension FavouriteViewModel {
        
    func getNews() {
        ArticleRepository.shared.fetchArticles()
            .sink(receiveCompletion: { completion in
            }, receiveValue: { [weak self] articles in
                guard let self = self else { return }
                if !articles.isEmpty {
                    self.articles = articles
                } else {
                    self.articles = []
                    self.showError.send("No articles found")
                }
                self.updateView.send(true)
            })
            .store(in: &cancellables)
    }
    
}

