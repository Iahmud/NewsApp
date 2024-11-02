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

}
