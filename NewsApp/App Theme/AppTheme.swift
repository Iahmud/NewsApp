//
//  AppTheme.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//


import UIKit

class AppTheme {
    static let shared = AppTheme()
    
    var mainColor = UIColor(named: "mainColor")
    var blackColor = UIColor(named: "blackColor")
    var redColor = UIColor(named: "redColor")
    var screenBackgroundColor = UIColor(named: "screenBackgroundColor")
    var surfaceColor = UIColor(named: "surfaceColor")
    var whiteColor = UIColor(named: "whiteColor")
    var textBackgroundColor = UIColor(named: "textBackgroundColor")
    var grayColor = UIColor(named: "grayColor")

    
    var screenTitleFont: UIFont = AppFontSetup.bold.size(FontSize.screenTitle)
    var boldFont: UIFont = AppFontSetup.bold.size(FontSize.boldText)
    var textFont: UIFont = AppFontSetup.regular.size(FontSize.regularText)
    var detailsFont: UIFont = AppFontSetup.regular.size(FontSize.detailsText)
    var textSmallFont: UIFont = AppFontSetup.light.size(FontSize.smallText)
}
