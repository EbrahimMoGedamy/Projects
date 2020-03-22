//
//  ViewController.swift
//  Sa-Localization
//
//  Created by Khaled on 8/1/18.
//  Copyright © 2018 Khaled. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func changeLanguagesAction(_ sender: UIButton) {
        Language.setAppLanguage(language: sender.tag == 10 ? "ar" : "en")
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddViewController")
        present(vc!, animated: true, completion: nil)
    }
}

