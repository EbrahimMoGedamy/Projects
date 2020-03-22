//
//  Helper.swift
//  MomCare
//
//  Created by Ebrahim  Mo Gedamy on 3/19/20.
//  Copyright © 2020 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
class helper: NSObject {

   class func restartApp() {
     
     guard let window = UIApplication.shared.keyWindow else {return}
     
     let sb = UIStoryboard(name: "Main", bundle: nil)
     
     var vc : UIViewController
    
        if getData() == nil {
            vc = sb.instantiateInitialViewController()!
        }
            
        else {
            
             vc = sb.instantiateViewController(withIdentifier:"Tabbar")
        }
    
      window.rootViewController = vc
      UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
     
     }
    
    class func saveData(key: String, name: String, id: Int, phone: String, avatar: String, rate: Int) {
        
        let def = UserDefaults.standard
//        def.set(key, forKey: "key")
//        def.setValue(id, forKey: "id")
//        def.setValue(name, forKey: "name")
//        def.setValue(phone, forKey: "phone")
//        def.setValue(avatar, forKey: "avatar")
//        def.setValue(rate, forKey: "rate")
        def.synchronize()
        
        guard let window = UIApplication.shared.keyWindow else {return}
      
//        let vc = Storyboard.Main.instantiate(Tabbar.self)
//        vc.selectedIndex = 0
//        window.rootViewController = vc
        
        restartApp()
    }
    
    class func getData() -> Any? {
        
        let def = UserDefaults.standard
      //  return def.object(forKey: "key") as? String
        return def.object(forKey: "id") as? Int
      //  return def.object(forKey: "name") as? String
      //  return def.object(forKey: "phone") as? String
      //  return def.object(forKey: "avatar") as? String
     //   return def.object(forKey: "rate") as? Int
        
    }
    
}
