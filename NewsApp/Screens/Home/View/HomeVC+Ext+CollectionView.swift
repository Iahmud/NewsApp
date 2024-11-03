//
//  HomeVC+Ext+CollectionView.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

extension HomeVC {
    func setupCollectionView() {
        cv.registerNibCell(NewsCvCell.self)
        cv.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        refreshControl.addTarget(self, action: #selector(self.fetchData), for: .valueChanged)
        cv.addSubview(refreshControl)
    }
}

extension HomeVC : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cv.configure(NewsCvCell.self, with: viewModel.cellForItemAt(indexPath.row) , for: indexPath)
    }
    
}


extension HomeVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.gotoDetais(viewModel.getSelectedCell(indexPath.row))
    }
    
}

extension HomeVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.size.width-40)/2
        return CGSize(width: width, height: width*1.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    
}
