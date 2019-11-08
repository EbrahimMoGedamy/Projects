//
//  SecondViewController.swift
//  reusablePopUpDemo
//
//  Created by Ebrahim  Mo Gedamy on 9/25/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectDateBu(_ sender: UIButton) {
          
          
          let datePopUpVC = self.storyboard?.instantiateViewController(withIdentifier: "datePopUpVC") as! DatePopUpVC
          datePopUpVC.modalPresentationStyle = .overCurrentContext
          datePopUpVC.modalTransitionStyle = .flipHorizontal
          self.definesPresentationContext = true
          self.present(datePopUpVC, animated: true, completion: nil)
          
          
      }
}

