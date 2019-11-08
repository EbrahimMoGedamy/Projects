//
//  NoteListVC.swift
//  noteApp
//
//  Created by Ebrahim  Mo Gedamy on 7/24/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import  CoreData

class NoteListVC: UIViewController  , UITableViewDelegate , UITableViewDataSource {

   
    @IBOutlet weak var myTableView: UITableView!
    
    var notesArr = [MyNotes]( )
    override func viewDidLoad() {
        super.viewDidLoad()
       myTableView.tableFooterView = UIView( )
        self.loadNotes()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCellVC
        cell.setCell(note: notesArr[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
  func loadNotes(){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyNotes")
    
    do{
    notesArr = try context.fetch(fetchRequest) as! [MyNotes]
   myTableView.reloadData()
    }catch  {
    print("Fetch Error")
    }
  }
    
    @IBAction func backBu(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
