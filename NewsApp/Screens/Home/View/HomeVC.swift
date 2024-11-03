//
//  HomeVC.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit
import Combine

class HomeVC: BaseVC {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var viewFavourite: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewDatePicker: UIView!
    @IBOutlet weak var labFrom: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cv: UICollectionView!
    
    var refreshControl = UIRefreshControl()
    var viewModel : HomeViewModelProtocol = HomeViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsLayout()
        bindView()
        fetchData()
    }
    
    
    @objc func fetchData() {
        viewModel.fetchData()
    }
    
    private func hideLoading() {
        coordinator?.hideLoading()
        refreshControl.endRefreshing()
        
    }
    
    private func showLoading() {
        coordinator?.showLoading(self)
    }
    
    @IBAction func btnFavourite(_ sender: Any) {
        coordinator?.gotoFavourite()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        coordinator?.back()
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        viewModel.filterDate(with: datePicker.date)
    }
   
}


//MARK: - Bind Views

extension HomeVC {
    
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
        
        viewModel.updateView
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] updateView in
                self?.hideLoading()
                self?.cv.reloadData()
            }).store(in: &subscriptions)
        
        viewModel.updateFilter
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] filter in
                self?.fillFilter(filter)
            }).store(in: &subscriptions)
        
    }
    
}


//MARK: - UI

extension HomeVC {
    func setupViewsLayout() {
        setupCollectionView()
        setupLabels()
        setupSearch()
        setupPicker()
        setupPageType()
    }
    
    func setupLabels() {
        labTitle.applyStyle(.screenTitle)
        labFrom.applyStyle(.text)
    }
    
    func setupSearch() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for News"
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
    }
    
    func setupPageType() {
        viewBack.isHidden = !viewModel.isFilterHidden
        labTitle.text = viewModel.title
        viewFavourite.isHidden = viewModel.isFilterHidden
        searchBar.isHidden = viewModel.isFilterHidden
        viewDatePicker.isHidden = viewModel.isFilterHidden
    }
    
    func fillFilter(_ data:NewsRequestModel) {
        datePicker.setDate(data.date?.toDate() ?? Date(), animated: true)
        searchBar.text = data.search
    }
    
}


//MARK: - UISearchBar


extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        viewModel.searchArticles(with: searchText)
        searchBar.resignFirstResponder()
    }
    
}




//MARK: - Date Picker

extension HomeVC {

    func setupPicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
    }
    
}

