//
//  AppFontSetup.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

enum AppFontSetup: String {
    case bold = "Bold"
    case regular = "Regular"
    case light = "Light"
        
    
    func size(_ size: CGFloat) -> UIFont {
        UIFont(name: fullFontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    fileprivate var fullFontName: String {
        "Tajawal-" + rawValue
    }
    
 

}
