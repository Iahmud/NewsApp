//
//  TableView_Extension.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

extension UITableView {
    
    func registerNibCell<T: SelfConfiguringCell>(_ cellType: T.Type) {
        let nibCell = UINib(nibName: cellType.reuseIdentifier, bundle: nil)
        self.register(nibCell, forCellReuseIdentifier: cellType.reuseIdentifier)
        
    }
    
    func configure<T: SelfConfiguringCell, datatype>(_ cellType: T.Type, with dataModel: datatype, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: dataModel)
        return cell
    }
    
    func configureHeader<T: SelfConfiguringCell, datatype>(_ cellType: T.Type, with dataModel: datatype) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: dataModel)
        return cell
    }
 
}


