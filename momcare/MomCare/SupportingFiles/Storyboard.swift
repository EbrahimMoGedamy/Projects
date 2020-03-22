//
//  Storyboard.swift
//  MomCare
//
//  Created by Ebrahim  Mo Gedamy on 3/19/20.
//  Copyright © 2020 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

public enum Storyboard: String {
    //storyBoards in APP
    case Splash
    case Authentication
    case Home
    case Main
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        var detectLang: String!
        if Language.currentLanguage().contains("en") {
            detectLang = "Base"
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else if Language.currentLanguage().contains("ar") {
            detectLang = "Base"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        let path = Bundle.main.path(forResource: detectLang , ofType: "lproj")
        let bundd = Bundle.init(path: path!)
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: bundd)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        return vc
        
    }
}
