//
//  RegisterVC.swift
//  webServicesDemo
//
//  Created by Ebrahim  on 7/3/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameTFR: UITextField!
    @IBOutlet weak var emailTFR: UITextField!
    @IBOutlet weak var passwordTFR: UITextField!
    @IBOutlet weak var cPasswordTFR: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerBU(_ sender: Any) {
        
        guard let name = nameTFR.text?.trimmed , name.isEmpty == false ,let email = emailTFR.text?.trimmed , email.isEmpty == false  ,let password = passwordTFR.text?.trimmed  , let cpassword = cPasswordTFR.text?.trimmed , cpassword.isEmpty == false else {return}
        guard password == cpassword else {return}
        
        Api.register(name: name, email: email, password: password) { (error : Error?,  success : Bool) in
            if success {
                print( "finally , registeration successded" )
            }
        }
        
        //            self.nameTFR.text = " "
        //            self.emailTFR.text = " "
        //            self.passwordTFR.text = " "
        //            self.cPasswordTFR.text = " "
        
    }
    
    
}
