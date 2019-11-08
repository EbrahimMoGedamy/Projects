//
//  ViewController.swift
//  swageApp
//
//  Created by Ebrahim  on 6/22/19.
//  Copyright © 2019 Ebrahim . All rights reserved.
//

import UIKit

class CatagoriesVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var shopCat: UILabel!
    @IBOutlet weak var catTableView: UITableView!
    var arrayOfName = ["Hodies","Shirts","Hats"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataServices.instanceOfData.getCategory().count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfCategory") as? CategoryCell {
            let categories = DataServices.instanceOfData.getCategory()[indexPath.row]
            cell.update(category: categories)
          
            return cell
        }else{
            return CategoryCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categories = DataServices.instanceOfData.getCategory()[indexPath.row]
        performSegue(withIdentifier: "productVCSegue", sender: categories)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let prepareSegue = segue.destination as? ProductsVC{
            var barBu = UIBarButtonItem( )
            barBu.title = " "
            navigationItem.backBarButtonItem = barBu
            assert(sender as? Category != nil)
            prepareSegue.initProducts(category: sender as! Category )
            
        }
    }

}
