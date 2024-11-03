//
//  CollectionView_Extension.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//


import UIKit

extension UICollectionView {
    
    func registerNibCell<T: SelfConfiguringCell>(_ cellType: T.Type) {
        let nibCell = UINib(nibName: cellType.reuseIdentifier, bundle: nil)
        self.register(nibCell, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        
    }
    
    func configure<T: SelfConfiguringCell, datatype>(_ cellType: T.Type, with dataModel: datatype, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: dataModel)
        return cell
    }
    
}
