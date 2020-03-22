//
//  ViewController.swift
//  notaficationCenterDemo
//
//  Created by Ebrahim  Mo Gedamy on 11/25/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(fireNotifcation(notifcation:)), name: NSNotification.Name("Fire Notifacation"), object: nil)
        
    }

    @objc func fireNotifcation(notifcation : Notification) {
        let userInfo = notifcation.userInfo
        if let date = userInfo?["DOB"] {
            self.titleLbl.text = date as? String
        }
    }
    
    @IBAction func nextBuTapped(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(identifier: "SecondVC") as! SecondVC
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

