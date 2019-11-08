//
//  ViewController.swift
//  today
//
//  Created by Ebrahim  Mo Gedamy on 7/21/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit

class TodoTableVC: UITableViewController {

    private let cellID = "todoCell"
    var itemsArr = [Item]( )
    
    // use user deafults to alawys assesting data
    let deafults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let newItem = Item( )
        newItem.done = true
        newItem.title = "Apple"
        itemsArr.append(newItem)
        
        
        
        tableView.tableFooterView = UIView()
        if let items = deafults.array(forKey: "TodoListArr") as? [String] {
            itemsArr = items
        }
    }
    
    // Add New Items
    @IBAction func addItemsBu(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert  = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print("Item Is Added Successfully")
            self.itemsArr.append(textField.text!)
            self.deafults.set(self.itemsArr, forKey: "TodoListArr")
            self.tableView.reloadData()
        }
     
    
        alert.addTextField {(textFieldAlert) in
            textFieldAlert.placeholder = "Creat New Item"
            textField = textFieldAlert
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension TodoTableVC {
    
    
    // TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = itemsArr[indexPath.row]
        return cell
    }
    
    // TableView Delgate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // to add checkMark && remove it again
       
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        print("didSelectedCell @ index : \(indexPath.row) of itemArr : \(itemsArr[indexPath.row])")
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // to enable user to press any cell
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
























// after login to my app this func restart my app to launch main screen

//class func restartApp( ){
//
//    guard let window = UIApplication.shared.keyWindow else {return}
//    let storyBoard = UIStoryboard.init(name: "Name", bundle: nil)
//    var vc = UIViewController()
//    if getApiToken() == nil{
//        vc = storyBoard.instantiateInitialViewController()!
//    }else{
//        vc = storyBoard.instantiateViewController(withIdentifier: "main")
//    }
//    window.rootViewController = vc
//    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
//
//}
