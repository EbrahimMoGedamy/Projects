//
//  AddStoreVC.swift
//  StoreApp
//
//  Created by Ebrahim  Mo Gedamy on 7/24/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class AddStoreVC: UIViewController {

    @IBOutlet weak var storeNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveStoreBu(_ sender: UIButton) {
        
        let store = StoreType(context: context)
        store.name = storeNameTF.text
        
        do {
            appDelegate.saveContext()
            storeNameTF.text = " "
            storeNameTF.placeholder = "type store name"
            print(" \(store.name ?? "") Store is saved successfully")
        } catch  {
            print("Error")
        }
        
    }
    
    
    @IBAction func backBu(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
