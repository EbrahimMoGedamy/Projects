//
//  ViewController.swift
//  cusromTableViewCell
//
//  Created by Ebrahim  Mo Gedamy on 12/31/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //CaseIterable ==> enable dev to confirm enum cases as array to use it like in TableViewSections
    enum TableSections : CaseIterable {
        case Foods
        case Games
        case Prayies
        
        var sectionHeader : String{
            switch self{
            case .Foods:
                return "Foods Sections"
            case .Games:
                return "Games Sections"
            case .Prayies:
                return "Prayies Sections"
            @unknown default:
                return "no section"
            }
        }
    }
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
//        myTableView.register(UINib(nibName: "DetailsTVCell", bundle: nil), forCellReuseIdentifier: "DetailsTVCell")
        myTableView.registerCell(cell: DetailsTVCell.self)
        
    }


}


extension ViewController : UITableViewDelegate {
    
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTVCell", for: indexPath) as! DetailsTVCell
        let cell = tableView.dequeCell() as DetailsTVCell
        cell.textLable.text = "Code Zilla"
        let section = TableSections.allCases[indexPath.section]
        
        switch section {
            
        case .Foods:
            cell.textLable.text = "I need a piece of meat"
        case .Games:
            cell.textLable.text = "i prefer to play fifa 2019"
        case .Prayies:
            cell.textLable.text = "let's pray"
        @unknown default:
            print("Code Zilla")
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let mySection = TableSections.allCases[section]
        return mySection.sectionHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mySection = TableSections.allCases[indexPath.section]
        switch mySection{
                   
               case .Foods:
                   print ("Foods Sections")
               case .Games:
                   print( "Games Sections")
               case .Prayies:
                   print ("Prayies Sections")
               @unknown default:
                   print ("no section")
               }
    }
}
