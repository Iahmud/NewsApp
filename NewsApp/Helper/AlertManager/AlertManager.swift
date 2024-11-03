//
//  AlertManager.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

class AlertManager{
    static func showalert(_ type: AlertType, vc:UIViewController) {
        let alertText = type.getData(type)
        let alert = UIAlertController(title: alertText.title , message: alertText.message , preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: alertText.cancelText , style: .default) {_ in }
        cancelAction.setValue(AppTheme.shared.redColor, forKey: "titleTextColor")
        alert.addAction(cancelAction)
        
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
}
