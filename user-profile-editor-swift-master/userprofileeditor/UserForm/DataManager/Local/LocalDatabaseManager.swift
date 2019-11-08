//
//  Countries.swift
//  userprofileeditor
//
//  Created by Ahmed Adel on 9/16/17.
//
//

import Foundation
import UIKit

/**
 Countries class is acting like a local data manager class that retrieve countries by getting
 them from NSLocale class
 **/

class LocalDatabaseManager: LocalDatabaseManagerUserFormProtocol {
    
    func getCountries() -> [String] {
        let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }
        return countries
    }
    
}
