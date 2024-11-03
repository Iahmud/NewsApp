//
//  DetailsVC.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit
import Combine

class DetailsVC: BaseVC {
    
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var labAddToFavourite: UILabel!
    @IBOutlet weak var tv: UITableView!
    
    var viewModel  = DetailsViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsLayout()
        bindView()
    }
    
   
    
    private func hideLoading() {
        coordinator?.hideLoading()
    }
    
    private func showLoading() {
        coordinator?.showLoading(self)
    }
    
    @IBAction func btnAddToFavourite(_ sender: Any) {
        viewModel.saveArticle()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        coordinator?.back()
    }
    
}


//MARK: - Bind Views

extension DetailsVC {
    
    private func bindView() {
        viewModel.loading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoading in
                isLoading ? self?.showLoading() : self?.hideLoading()
            }).store(in: &subscriptions)
        
        viewModel.showError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                guard let self = self else {return}
                self.hideLoading()
                self.coordinator?.showToast(error, in: self)
            }).store(in: &subscriptions)

        
    }
    
}


//MARK: - UI

extension DetailsVC {
    func setupViewsLayout() {
        setupTableView()
        setupLabels()
        
    }
    
    func setupLabels() {
        labTitle.applyStyle(.screenTitle)
        labAddToFavourite.applyStyle(.title, color: AppTheme.shared.whiteColor)
    }
  
    
}
