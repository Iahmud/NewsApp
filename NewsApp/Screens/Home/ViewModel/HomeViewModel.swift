//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation
import Combine

class HomeViewModel: HomeViewModelProtocol {
    var title = "News"
    var isFilterHidden = false
    
    var updateView = PassthroughSubject<Bool, Never>()
    var loading = PassthroughSubject<Bool, Never>()
    var showError = PassthroughSubject<String, Never>()
    var updateFilter = CurrentValueSubject<NewsRequestModel, Never>(NewsRequestModel(search: "apple", date: "2024-11-1"))

    var articles: [ArticleModel] = []
       
    private var cancellables = Set<AnyCancellable>()
 
    private var requestModel = NewsRequestModel(search: "apple", date: "2024-11-1")

    var numberOfRowsInSection: Int { articles.count }

    func fetchData() {
        getNews()
    }
    
}


//MARK: - UISearchBar
extension HomeViewModel {
    func searchArticles(with search: String) {
        guard search != "" else {
            showError.send("Please enter search text")
            updateFilter.send(requestModel)
            return
        }
        requestModel.search = search
        getNews()
    }

}

//MARK: - UISearchBar
extension HomeViewModel {
    func filterDate(with date: Date) {
        requestModel.date = date.toString()
        getNews()
    }

}

//MARK: - Collection View
extension HomeViewModel {
    func cellForItemAt(_ index:Int) -> NewsCvCellProtocol {
        NewsCvCellImplementation( articles[index] )
    }
    
    func getSelectedCell(_ index:Int) -> ArticleModel {
         articles[index]
    }
}

//MARK: - Api Request


extension HomeViewModel {
    
    private func getNews() {
        print("requestModel::: \(requestModel)")
        loading.send(true)
        
        let serviceName = ServiceName.everyThing(requestModel)
        
        NetworkingManager.shared.fetchDataPublisher(serviceName)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.loading.send(false)
            }, receiveValue: { [weak self] (newsResponse: NewsResponse) in
                guard let self = self else { return }
                
                if newsResponse.status == "ok",
                   let articles = newsResponse.articles,
                    !articles.isEmpty {
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

