//
//  ViewController.swift
//  KKDefaults
//
//  Created by khaledkamal on 4/30/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Defaults.isLogin.save(true)
        
        guard let islogin : Bool  = Defaults.isLogin.get()  else {
            print("ee")
            return
        }
        print(islogin)
        
        Defaults.id.save(12)
        Defaults.lang.save("en")
        Defaults.user.save(User())
        guard let value : User  = Defaults.user.get()  else {
            print("ee")
            return
        }
        print(value)

    }


}


struct User : Codable {
    
    let name : String = ""
    let id : Int = 10
}
