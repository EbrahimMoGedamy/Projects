//
//  ViewController.swift
//  resetPasswordApp
//
//  Created by Ebrahim  Mo Gedamy on 11/10/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var emailTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func displayMessage(userMessage : String) {
        let alert = UIAlertController(title: "Reset Password", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
         
    }
    @IBAction func sendBuPreesed(_ sender: UIButton) {
        
        let emailAddress = self.emailTxtField.text
        if emailAddress!.isEmpty{
            // print warning message
            let userMessage = "please , type your email address"
            displayMessage( userMessage: userMessage)
            print("successful")
            return
        }
        
        PFUser.requestPasswordResetForEmail(inBackground: emailAddress!) { (success : Bool, error : Error?) in
            
            if error == nil {
                // print message
                let message = "your message was sent successfully to your email address \(String(describing: emailAddress))"
                self.displayMessage(userMessage: message)
            }else{
                // print error
                self.displayMessage(userMessage : error!.localizedDescription)
            }
        }
    }
    
    @IBAction func cancleBuPreesed(_ sender: UIButton) {
        
        
    }
}

