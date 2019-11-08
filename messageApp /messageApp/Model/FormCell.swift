//
//  FormCell.swift
//  messageApp
//
//  Created by Ebrahim  Mo Gedamy on 7/14/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class FormCell: UICollectionViewCell , UITextFieldDelegate {
    
    
    @IBOutlet weak var userNameContainer: UIView!
    @IBOutlet weak var userNameTxtField : UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var register: UIButton!
    
    
//    @objc func collectionViewTapped( ){
//        userNameTxtField.endEditing(true)
//        emailTxtField.endEditing(true)
//        passwordTxtField.endEditing(true)
//    }
    @IBAction func loginBu(_ sender: UIButton) {
    
        
    }
    
    @IBAction func registerBu(_ sender: UIButton) {
       
        
    }
    
}
