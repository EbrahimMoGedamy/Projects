//
//  ViewController.swift
//  StoreApp
//
//  Created by Ebrahim  Mo Gedamy on 7/24/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController , UITableViewDelegate , UITableViewDataSource , NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var tableViewHome: UITableView!
    var itemsArr = [Items]()
    var fetchController : NSFetchedResultsController<Items>!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        tableViewHome.tableFooterView = UIView()
        self.loadItems()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchController.sections {
            let secionInfo = sections[section]
            return secionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemsCellVC
        self.configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = fetchController.fetchedObjects{
            let item = obj[indexPath.row]
            performSegue(withIdentifier: "editSegue", sender: item)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue"{
            if let destination = segue.destination as? AddItemsVC {
                if let item = sender as? Items {
                    destination.editDeletObj = item
                }
            }
        }
    }
    func configureCell(cell: ItemsCellVC , indexPath : NSIndexPath){
        
        let item = fetchController.object(at: indexPath as IndexPath)
        cell.setCell(item: item)
    }
    
    func loadItems()  {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        
        
        // start : to sort items by date
        let sortedItems = NSSortDescriptor(key: "addedDataDate", ascending: false)
        fetchRequest.sortDescriptors = [sortedItems]
        // end...
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil) as? NSFetchedResultsController<Items>
        fetchController.delegate = self
        //        do{
        //            itemsArr = try context.fetch(fetchRequest) as! [Items]
        //
        //        }
        do {
            try fetchController.performFetch()
        }catch  {
            print("Fetch Items Error")
        }
        
    }
    
    // to update items in tableView
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewHome.beginUpdates()
    }
    
    // to end update items in tableView
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewHome.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath:  IndexPath?) {
        // fetching data sequentially in tableView
        switch type {
        case .insert :
            if let indexPath = newIndexPath{
                tableViewHome.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete :
            if let indexPath = newIndexPath{
                tableViewHome.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = newIndexPath ,let cell = tableViewHome.cellForRow(at: indexPath) {
                configureCell(cell: cell as! ItemsCellVC, indexPath: indexPath as NSIndexPath)
            }
            break;
        case .move:
            if let indexPath = indexPath {
                tableViewHome.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableViewHome.insertRows(at: [newIndexPath], with: .fade)
            }
            break;
        default:
            print("...")
        }
        
        
    }
    
    
}
