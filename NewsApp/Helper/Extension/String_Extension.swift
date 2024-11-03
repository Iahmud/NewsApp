//
//  String_Extension.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import Foundation

extension String{
    func localizeString() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    
}
