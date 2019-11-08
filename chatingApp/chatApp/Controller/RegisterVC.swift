//
//  RegisterVC.swift
//  chatApp
//
//  Created by Ebrahim  on 6/24/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterVC: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var registerEpasswordTextfield: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerEpasswordTextfield.delegate = self
        registerEmailTextField.delegate = self
//        textFieldShouldReturn(registerEpasswordTextfield)
//        textFieldShouldReturn(registerEmailTextField)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        return true
    }
    @IBAction func registerBuRegister(_ sender: Any) {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: registerEmailTextField.text!, password: registerEpasswordTextfield.text!) { (user, error) in
            if error != nil {
                print(error!)
            }else{
                
                print("successful")
                SVProgressHUD.dismiss()
          self.performSegue(withIdentifier: "registerIntoChat", sender: self )
            }
         
        }
    }
    
}
