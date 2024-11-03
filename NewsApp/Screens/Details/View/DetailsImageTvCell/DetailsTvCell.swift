//
//  DetailsTvCell.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

class DetailsTvCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension DetailsTvCell : SelfConfiguringCell{
    static let reuseIdentifier: String = "DetailsTvCell"
    func configure<T>(with data: T) {
        guard let recveddata:NewsCvCellProtocol = data as? NewsCvCellProtocol else{
            return
        }
        setupCellView()
        newsImage.kf.setImage(with:  URL(string: recveddata.image), placeholder: UIImage(named: "plsceholder"))

        labTitle.text = recveddata.title
        labAuthor.text = recveddata.author
        labDetails.text = recveddata.details
        viewAuthor.isHidden = recveddata.isViewAuthorHidden
        
    }
}

