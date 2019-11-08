//
//  DatePopUpVC.swift
//  reusablePopUpDemo
//
//  Created by Ebrahim  Mo Gedamy on 9/25/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class DatePopUpVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveDateBu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveDatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
        print("mmm")
    }
    
}
