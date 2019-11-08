//
//  ViewController.swift
//  RESTFULApi
//
//  Created by Ebrahim  Mo Gedamy on 9/28/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    var myTableView : UITableView!
    var items = [UserObjects]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.buildTableView()
        self.buildButton()
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
    }

    @objc func addDummyData(){
        // Call API
        RESTFULApiManager.sharedInstance.getRandomUser { (json : JSON) in
            // Return JSON from Api
            if let results = json["results"].array {
                for index in results {
                    self.items.append(UserObjects(json : index))
                }
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            }
        }
    }
    
    func buildTableView() {
        let frame: CGRect = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height-100)
        self.myTableView = UITableView(frame: frame)
        self.view.addSubview(self.myTableView)
    }
    func buildButton() {
        let btn = UIButton(frame: CGRect(x: 0, y: 25, width: self.view.frame.width, height: 50))
        btn.backgroundColor = UIColor.cyan
        btn.setTitle("Add new Dummy", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(self.addDummyData), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btn)
    }
}


extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "myCell")
        }
        let user = self.items[indexPath.row]
        if let url = NSURL(string: user.pictureURL) {
            if let data = NSData(contentsOf: url as URL) {
                cell?.imageView?.image = UIImage(data: data as Data)
            }
        }
        cell?.textLabel?.text = user.username
        
        return cell!
    }
    
    
}
