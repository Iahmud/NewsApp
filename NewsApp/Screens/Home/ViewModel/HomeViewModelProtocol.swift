//
//  HomeViewModelProtocol.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    var title: String { get set }
    var isFilterHidden: Bool { get set }
    var updateView : PassthroughSubject<Bool, Never>  { get set }
    var loading : PassthroughSubject<Bool, Never>  { get set }
    var showError : PassthroughSubject<String, Never>  { get set }
    var updateFilter : CurrentValueSubject<NewsRequestModel, Never>  { get set }

    var numberOfRowsInSection: Int { get }
    func fetchData()
    func searchArticles(with search: String)
    func filterDate(with date: Date)
    func cellForItemAt(_ index:Int) -> NewsCvCellProtocol
    func getSelectedCell(_ index:Int) -> ArticleModel
  
}

extension HomeViewModelProtocol {
    func searchArticles(with search: String) {}
    func filterDate(with date: Date) {}
}
