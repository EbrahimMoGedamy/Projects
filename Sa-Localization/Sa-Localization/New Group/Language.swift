//
//  Language.swift
//  Tarleem
//
//  Created by Khaled on 5/1/17.
//  Copyright © 2017 khalid. All rights reserved.
//

import Foundation
import UIKit

class Language {
    
    class func currentLanguage()->String {
        let def = UserDefaults.standard
        let lang = def.object(forKey: "AppleLanguages") as! NSArray
        let currentLanguage = lang.firstObject as! String
        return currentLanguage
    }
    
    class func setAppLanguage(language:String) {
        let def = UserDefaults.standard
        def.set([language,currentLanguage()], forKey: "AppleLanguages")
        def.synchronize()
        
        if language == "ar" {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UINavigationBar.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().textAlignment = .right
            UITextView.appearance().textAlignment = .right
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().textAlignment = .left
            UITextView.appearance().textAlignment = .left
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
    class func localizeStringForKey(word:String)->String{
        let localizedWord = NSLocalizedString(word, comment: "")
        return localizedWord
    }
}
