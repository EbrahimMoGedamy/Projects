//
//  LoginVC.swift
//  chatApp
//
//  Created by Ebrahim  on 6/24/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
    
    @IBAction func loginBu(_ sender: Any) {
        
        let email = emailTextfield.text!
        if email.isEmpty == true {
            return
        }
        let password = passwordTextfield.text!
        if password.isEmpty == true {
            return
        }
        
        let url = "http://127.0.0.1:8000/api/v1/login"
        let paramters = ["email :" : email , "password :" : password]
        
        Alamofire.request(url, method: .post, parameters: paramters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 100..<200)
            .responseJSON { (response) in
                switch response.result{
                case .failure(let error):
                    print(error)
                case .success(let value):
                    print(value)
                }
        }
        
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print(error!)
            }else{
                print(" you login successfully")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "loginIntoChat", sender: self )
                
            }
            
        }
    }
}
