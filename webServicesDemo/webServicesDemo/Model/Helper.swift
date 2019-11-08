//
//  Helper.swift
//  webServicesDemo
//
//  Created by Ebrahim  Mo Gedamy on 7/19/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class Helper {
    
    // after login to my app this func restart my app to launch main screen
    
    class func restartApp( ){

        guard let window = UIApplication.shared.keyWindow else {return}
        let storyBoard = UIStoryboard.init(name: "Name", bundle: nil)
        var vc = UIViewController()
        if getApiToken() == nil{
            vc = storyBoard.instantiateInitialViewController()!
        }else{
            vc = storyBoard.instantiateViewController(withIdentifier: "main")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
        
    }
    
    class func saveApiToken(token : String){
        
        // save api_token to keep deafult user
        let deafultUsers = UserDefaults.standard
        deafultUsers.set(token, forKey: "api_token")
        deafultUsers.synchronize()
    }
    
    
    // to detect if user rally register ==> skip to main screen
    class func getApiToken( )->String?{
        
        let deafultUsers = UserDefaults.standard
        return deafultUsers.object(forKey: "api_token") as? String
        
    }
}
