//
//  DetailsVC+Ext+TableView.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

extension DetailsVC {
    func setupTableView() {
        tv.registerNibCell(DetailsTvCell.self)
        tv.contentInset = UIEdgeInsets(top: 16,left: 0,bottom: 60,right: 0)
        tv.estimatedRowHeight = 60
        tv.rowHeight = 60
    }
}


extension DetailsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tv.configure(DetailsTvCell.self, with: viewModel.cellForRow(), for: indexPath)
    }
}



extension DetailsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
