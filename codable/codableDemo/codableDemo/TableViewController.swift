
//  ViewController.swift
//  codableDemo
//
//  Created by Ebrahim  Mo Gedamy on 7/12/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage



class TableViewController : UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var arrOfHeros = [Hero]( )
    
    let baseURl = URL(string: "https://simplifiedcoding.net/demos/marvel/")
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfHeros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.name.text = "nameOfHero : \(String(describing: (arrOfHeros[indexPath.row].name)!))"
        cell.team.text = "nameOfTeam : \(String(describing: (arrOfHeros[indexPath.row].team)!))"
        
        Alamofire.request(arrOfHeros[indexPath.row].imageurl!).responseImage { response in
            //debugPrint(response)
            
            if let image = response.result.value {
                cell.heroImage.image = image
            }
        }
        
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.rowHeight = 350
        //fetching data from web api
        //        Alamofire.request(url!).responseJSON { response in
        //
        //            //getting json
        //            if let json = response.result.value {
        //
        //                //converting json to NSArray
        //                let heroesArray : NSArray  = json as! NSArray
        
        //traversing through all elements of the array
        //                for i in 0..<heroesArray.count{
        //
        //                    //adding hero values to the hero list
        //                    self.arrOfHeros.append(Hero(
        //                        name: (heroesArray[i] as AnyObject).value(forKey: "name") as? String,
        //                        team: (heroesArray[i] as AnyObject).value(forKey: "team") as? String,
        //                        imageUrl: (heroesArray[i] as AnyObject).value(forKey: "imageurl") as? String
        //                    ))
        //
        //                }
        
        //displaying data in tableview
        // Alamofire with codable
        Alamofire.request(baseURl!).responseJSON { response in
            let data = response.data
            
            do{
                let decoder = JSONDecoder()
                let heros = try decoder.decode([Hero].self, from: data!)
                
                DispatchQueue.main.async {
                    self.arrOfHeros = heros
                    
                    self.tableView.reloadData()
                    for hero in self.arrOfHeros{
                        print(" nameOfActor : \(hero.name!)")
                    }
                    
                }
                
            }catch{
                print(error)
            }
        }
        self.tableView.reloadData()
        
    }
}





//let downloadedFriedsModel = try decoder.decode([Friend].self, from: data)
//
//DispatchQueue.main.async {
//    self.friends = downloadedFriedsModel
//    self.tableView.reloadData()



