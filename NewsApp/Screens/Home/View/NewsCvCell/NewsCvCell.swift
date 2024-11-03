//
//  NewsCvCell.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit
import Kingfisher

class NewsCvCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var viewAuthor: UIView!
    @IBOutlet weak var labAuthor: UILabel!
    @IBOutlet weak var labDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellView()
    }
    
    func setupCellView() {
        labTitle.applyStyle(.title)
        labAuthor.applyStyle(.text)
        labDetails.applyStyle(.detail)
    }
    
    
}


extension NewsCvCell : SelfConfiguringCell {
    static var reuseIdentifier: String {
        return "NewsCvCell"
    }
    
    func configure<T>(with data: T) {
        guard let recveddata:NewsCvCellProtocol = data as? NewsCvCellProtocol else{
            return
        }
        setupCellView()
        image.kf.setImage(with:  URL(string: recveddata.image), placeholder: UIImage(named: "plsceholder"))

        labTitle.text = recveddata.title
        labAuthor.text = recveddata.author
        labDetails.text = recveddata.details
        viewAuthor.isHidden = recveddata.isViewAuthorHidden
    }
    
    
}




