//
//  TasksVC.swift
//  webServicesDemo
//
//  Created by Ebrahim Mo Gedamy on 7/19/19.
//  Copyright © 2019 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit

class TasksVC: UIViewController {
    
    
    @IBOutlet weak var taskTableView: UITableView!
    private let tableCellId = "tasksCell"
    
    var tasks = [Task]( )
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.delegate = self
        taskTableView.dataSource = self 
       taskTableView.register(UITableViewCell.self, forCellReuseIdentifier: tableCellId )
    }
    
    // func to store data
    private func handleRefres(){
        Api.tasks { (error : Error?, task :[Task]?) in
            if let tasks = task {
                self.tasks = task!
                self.taskTableView.reloadData()
        }
        
    }
    
 }
}

extension TasksVC : UITableViewDelegate ,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].task
        return cell
    }
    // to enable user to press any cell
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

