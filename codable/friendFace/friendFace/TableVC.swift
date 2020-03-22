//
//  ViewController.swift
//  friendFace
//
//  Created by Ebrahim Mo Gedamy on 7/10/19.
//  Copyright © 2019 E.brahim Mo Gedamy. All rights reserved.
//

import UIKit


class TableVC: UITableViewController  , UISearchResultsUpdating , UISearchBarDelegate , UISearchControllerDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    
    var friends : [Friend] = []
    var friendsData : Friend?
    var filteredFriends = [Friend]( )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = true
        search.searchResultsUpdater = self
        navigationItem.searchController = search
        search.searchBar.placeholder = "find a friend"
        
        
        
        DispatchQueue.global().async {
            do{
                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder( )
                decoder.dateDecodingStrategy = .iso8601 // to get date formate
                
                let downloadedFriedsModel = try decoder.decode([Friend].self, from: data)
                
                DispatchQueue.main.async {
                    self.friends = downloadedFriedsModel
                    self.filteredFriends = downloadedFriedsModel
                    self.tableView.reloadData()
                    
                }
                
            }catch{
                print("Error : \(error.localizedDescription)")
            }
        }
        
//        DispatchQueue.global().async {
//            do{
//                let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
//                let data = try Data(contentsOf: url)
//
//                let decoder = JSONDecoder( )
//                decoder.dateDecodingStrategy = .iso8601 // to get date formate
//
//                let downloadedFriedsModel = try decoder.decode([Friend].self, from: data)
//
//                DispatchQueue.main.async {
//                    self.friends = downloadedFriedsModel
//                    self.filteredFriends = downloadedFriedsModel
//                    self.tableView.reloadData()
//
//                }
//
//            }catch{
//                print("Error : \(error.localizedDescription)")
//            }
//        }
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friends.map{ $0.name}.joined(separator: ",")
        
        return cell
        
    }
    
    
    func UpdateSearchResults(for SearchController : UISearchController) {
        
        if let text = SearchController.searchBar.text , text.count > 0 {
            
            filteredFriends = friends.filter {
                
                ($0.name?.contains(text))!
                    || ($0.company?.contains(text))!
                    || ($0.address?.contains(text))!
                
            }
        }else{
            filteredFriends = friends
        }
        tableView.reloadData()
    }
}



