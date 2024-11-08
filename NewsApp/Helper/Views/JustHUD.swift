//
//  JustHUD.swift
//  mWELL
//
//  Created by Shubham Naik on 11/07/17.
//  Copyright © 2017 Shubham. All rights reserved.
//

import UIKit

class JustHUD: UIView {
    private var backView: UIView?
    private var progressIndicator: UIActivityIndicatorView?
    private var titleLabel: UILabel?
    private var footerLabel: UILabel?
    
    //Customizable properties
    private var headerColor = AppTheme.shared.screenBackgroundColor
    private var footerColor = AppTheme.shared.screenBackgroundColor
    private var backColor = AppTheme.shared.mainColor
    private var loaderColor = #colorLiteral(red: 0.2010305226, green: 0.2725443542, blue: 0.3995640278, alpha: 1)
  
  
    
    ///Shared instance for easy access
    static let shared = JustHUD()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: Customizing methods
    class func setHeaderColor(color: UIColor) {
        shared.headerColor = color
    }
    
    class func setFooterColor(color: UIColor) {
        shared.footerColor = color
    }
    
    class func setLoaderColor(color: UIColor) {
        shared.loaderColor = color
    }
    
    class func setBackgroundColor(color: UIColor, automaticTextColor: Bool = false) {
        shared.backColor = color
        if automaticTextColor {
            shared.headerColor = getComplementaryForColor(color: color, relativeTo: shared.headerColor!)
            shared.footerColor = getComplementaryForColor(color: color, relativeTo: shared.footerColor!)
            shared.loaderColor = getComplementaryForColor(color: color, relativeTo: shared.loaderColor)
        }
    }

    /// Show the loader added to the mentioned view with the provided title and footer texts
    func showInView(view: UIView, withHeader: String? = GlobalVar.shared.appName, andFooter: String? = GlobalVar.shared.appName) {
        self.hide()
        self.frame = view.bounds
        setIndicator()
        
        if let title = withHeader, !isCleanedStringEmpty(string: title) {
            setTitleLabel(text: title)
            titleLabel!.frame = CGRect(x: 0, y: 0, width: getLabelSize().width, height: getLabelSize().height)
        }
        
        if let footer = andFooter, !isCleanedStringEmpty(string: footer) {
            setFooterLabel(text: footer)
            footerLabel!.frame = CGRect(x: 0, y: 0, width: getLabelSize().width, height: getLabelSize().height)
        }
        
        setBackGround(view: self)
        
        if let title = withHeader, !isCleanedStringEmpty(string: title) {
            titleLabel!.frame.origin = getHeaderOrigin(view: backView!)
            titleLabel?.adjustsFontSizeToFitWidth = true
            backView?.addSubview(titleLabel!)
        }
        
        if let footer = andFooter, !isCleanedStringEmpty(string: footer) {
            footerLabel!.frame.origin = getFooterOrigin(view: backView!)
            footerLabel?.adjustsFontSizeToFitWidth = true
            backView?.addSubview(footerLabel!)
        }
        
        progressIndicator?.frame.origin = getIndicatorOrigin(view: backView!, activityIndicatorView: progressIndicator!)
        backView?.addSubview(progressIndicator!)
        view.addSubview(self)
    }
    
    // Show the loader added to the mentioned window with the provided title and footer texts
    func showInWindow(window: UIWindow, withHeader title: String?, andFooter footer: String?) {
        self.showInView(view: window, withHeader: title, andFooter: footer)
    }
    
    // Show the loader added to the mentioned view with no title and footer texts
    func showInView(view: UIView) {
        self.showInView(view: view, withHeader: nil, andFooter: nil)
    }
    
    // Show the loader added to the mentioned window with no title and footer texts
    func showInWindow(window: UIWindow) {
        self.showInView(view: window, withHeader: nil, andFooter: nil)
    }
    
    /// Removes the loader from its superview to hide
    func hide() {
        if self.superview != nil {
            DispatchQueue.main.async {
                self.removeFromSuperview()
            }
            progressIndicator?.stopAnimating()
        }
    }
    
    var isActive: Bool {
        return self.superview != nil
    }
    
    // MARK: -Set view properties
    private func setBackGround(view: UIView) {
        if backView?.superview != nil {
            backView?.removeFromSuperview()
            let aView = backView?.viewWithTag(1001) as UIView?
            aView?.removeFromSuperview()
        }
        backView = UIView(frame: getBackGroundFrame(view: self))
        backView?.backgroundColor = UIColor.clear
        let translucentView = UIView(frame: backView!.bounds)
        translucentView.backgroundColor = backColor
        translucentView.alpha = 0.85
        translucentView.tag = 1001;
        backView?.addSubview(translucentView)
        backView?.layer.cornerRadius = 15.0
        backView?.clipsToBounds = true
        self.addSubview(backView!)
    }
    
    private func setIndicator() {
        if progressIndicator?.superview != nil {
            progressIndicator?.removeFromSuperview()
        }
        progressIndicator = UIActivityIndicatorView(style: .whiteLarge)
        progressIndicator?.style = UIActivityIndicatorView.Style.whiteLarge
        progressIndicator?.color = loaderColor
        progressIndicator?.backgroundColor = UIColor.clear
        progressIndicator?.startAnimating()
    }
    
    private func setTitleLabel(text: String) {
        if titleLabel?.superview != nil {
            titleLabel?.removeFromSuperview()
        }
        titleLabel = UILabel()
        titleLabel?.text = text
        titleLabel?.font = AppTheme.shared.textFont
        titleLabel?.textColor = headerColor
        titleLabel?.textAlignment = .center
    }
    
    private func setFooterLabel(text: String) {
        if footerLabel?.superview != nil {
            footerLabel?.removeFromSuperview()
        }
        footerLabel = UILabel()
        footerLabel?.text = text
        footerLabel?.textColor = footerColor
        footerLabel?.textAlignment = .center
        footerLabel?.font = AppTheme.shared.textFont
    }
    
    // MARK: -Get Frame
    private func getBackGroundFrame(view: UIView) -> CGRect {
        let sideMargin: CGFloat = 20.0
        var side = progressIndicator!.frame.height + sideMargin
        
        if titleLabel?.text != nil && !isCleanedStringEmpty(string: (titleLabel?.text)!) {
            side = progressIndicator!.frame.height + titleLabel!.frame.width
        } else if footerLabel?.text != nil && !isCleanedStringEmpty(string: (footerLabel?.text)!) {
            side = progressIndicator!.frame.height + footerLabel!.frame.width
        }
        let originX = view.center.x - (side/2)
        let originY = view.center.y - (side/2)
        return CGRect(x: originX, y: originY, width: side, height: side)
    }
    
    // MARK: Get Size
    private func getLabelSize() -> CGSize {
        let width = progressIndicator!.frame.width * 3
        let height = progressIndicator!.frame.height / 1.5
        return CGSize(width: width, height: height)
    }
    
    // MARK: -Get Origin
    private func getIndicatorOrigin(view: UIView, activityIndicatorView indicator: UIActivityIndicatorView) -> CGPoint {
        let side = indicator.frame.size.height
        let originX = (view.bounds.width/2) - (side/2)
        let originY = (view.bounds.height/2) - (side/2)
        return CGPoint(x: originX, y: originY)
    }
    
    private func getHeaderOrigin(view: UIView) -> CGPoint {
        let width = titleLabel!.frame.size.width
        let originX = (view.bounds.width/2) - (width/2)
        return CGPoint(x: originX, y: 1)
    }
    
    private func getFooterOrigin(view: UIView) -> CGPoint {
        let width = footerLabel!.frame.width
        let height = footerLabel!.frame.height
        let originX = (view.bounds.width/2) - (width/2)
        let originY = view.frame.height - (height + 1)
        return CGPoint(x: originX, y: originY)
    }
    
    private func isCleanedStringEmpty(string: String) -> Bool {
        let cleanString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleanString.isEmpty
    }
    
    // MARK: -Set Font
    func boldFontWithFont(font: UIFont?) -> UIFont {
        let fontDescriptor = font!.fontDescriptor.withSymbolicTraits(.traitBold)!
        return UIFont(descriptor: fontDescriptor, size: font?.pointSize ?? 0.0)
    }
    
    // MARK: Colors
    /// get a complementary color to this color:
    private class func getComplementaryForColor(color: UIColor, relativeTo: UIColor) -> UIColor {
        let original = CIColor(color: color)
        let relative = CIColor(color: relativeTo)
        
        // get the current values and make the difference from white
        let compRed = ((1.0 - original.red) + 0.3 * relative.red)/1.3
        let compGreen = ((1.0 - original.green) + 0.3 * relative.green)/1.3
        let compBlue = ((1.0 - original.blue) + 0.3 * relative.blue)/1.3
        
        return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
    }
}
