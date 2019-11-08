//
//  ViewController.swift
//  webServicesDemo
//
//  Created by Ebrahim  on 7/3/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBU(_ sender: UIButton) {
        let email = emailTF.text!
        let password = passwordTF.text!
        guard email.isEmpty == false else {  return  }
        guard password.isEmpty == false  else {  return }
        
        Api.login(email: email, password: password) { ( error : Error?, success : Bool) in
            if success {
                print("welcome our dear ")
            }else{
                print("dear user., plz try again ")
            }
        }
        
        //            self.emailTF.text = " "
        //            self.passwordTF.text = " "
    }
}

