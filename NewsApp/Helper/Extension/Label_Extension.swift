//
//  Label_Extension.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

extension UILabel{
    func applyStyle(_ style: LabelStyle, color: UIColor? = nil) {
        switch style {
        case .screenTitle:
            self.font = AppTheme.shared.screenTitleFont
            self.textColor = color ?? AppTheme.shared.blackColor
        case .title:
            self.font = AppTheme.shared.boldFont
            self.textColor = color ?? AppTheme.shared.blackColor
        case .text:
            self.font = AppTheme.shared.textFont
            self.textColor = color ?? AppTheme.shared.blackColor
        case .detail:
            self.font = AppTheme.shared.detailsFont
            self.textColor = color ?? AppTheme.shared.blackColor
        case .small:
            self.font = AppTheme.shared.textSmallFont
            self.textColor = color ?? AppTheme.shared.blackColor
        }
        self.text = self.text?.localizeString()
    }
    
}

enum LabelStyle {
    case screenTitle, title, text, detail, small
}
