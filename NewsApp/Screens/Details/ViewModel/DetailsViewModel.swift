//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation
import Combine

class DetailsViewModel: NSObject {
    
    var loading = PassthroughSubject<Bool, Never>()
    var showError = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    var article  = ArticleModel()
}



//MARK: - TableView View
extension DetailsViewModel {
    func cellForRow() -> NewsCvCellProtocol {
        NewsCvCellImplementation( article )
    }
}

//MARK: - CoreData Request

extension DetailsViewModel {
    
    func saveArticle() {
        ArticleRepository.shared.saveArticle(article)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { saved in
                if saved {
                    self.showError.send("Article saved")
                } else {
                    self.showError.send("Article already exists")
                }
            })
            .store(in: &cancellables)
    }
    
    
}

