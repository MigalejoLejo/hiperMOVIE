//
//  LangTools.swift
//  Movies
//
//  Created by Miguel Alejandro Correa Avila on 30/6/23.
//

import Foundation

extension String {
    func localizedLanguage() -> String {
        if let bundlePath = Bundle.main.path(forResource: UserService.sharedInstance.appLanguage, ofType: "lproj") {
            if let bundle = Bundle(path: bundlePath) {
                return bundle.localizedString(forKey: self, value: self, table: nil)
            }
        }
    
        return self
    }
}



