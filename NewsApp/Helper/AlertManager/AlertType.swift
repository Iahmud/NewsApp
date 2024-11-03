//
//  AlertType.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation

enum AlertType:Equatable {
    case SaveArticle(String)
    
    func getData(_ type: AlertType) -> AlertModel {
        let okText = "yes".localizeString()
        let cancelText = "cancel".localizeString()
        switch self {
        case .SaveArticle(let title):
            return AlertModel(title: title, message: "added to favourite successfully", okText: okText, cancelText: cancelText)
        }
        
    }
    
}
