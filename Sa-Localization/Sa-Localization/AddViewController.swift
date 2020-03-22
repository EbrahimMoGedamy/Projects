//
//  AddViewController.swift
//  Sa-Localization
//
//  Created by Khaled on 8/1/18.
//  Copyright © 2018 Khaled. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveAction(_ sender: UIButton) {
        let alert = UIAlertController(title: Language.localizeStringForKey(word: "addAlertTitle"),
                                      message: Language.localizeStringForKey(word: "addAlertMsg"),
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: Language.localizeStringForKey(word: "conf"),
                                      style: .destructive,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: Language.localizeStringForKey(word: "rej"),
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
