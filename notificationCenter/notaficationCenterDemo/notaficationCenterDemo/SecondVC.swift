//
//  SecondVC.swift
//  notaficationCenterDemo
//
//  Created by Ebrahim  Mo Gedamy on 11/25/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func fireNotafication(_ sender: Any) {
        var dict : Dictionary<String , Any> = Dictionary()
        dict.updateValue("1/2/1998" , forKey: "DOB")
        
        NotificationCenter.default.post(name: Notification.Name("Fire Notifacation"), object: nil, userInfo: dict)
        self.navigationController?.popViewController(animated: true)
        }
        
        
        
      
}
