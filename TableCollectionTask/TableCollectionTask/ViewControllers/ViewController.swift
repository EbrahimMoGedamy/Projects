//
//  ViewController.swift
//  TableCollectionTask
//
//  Created by Mohamed Gebril on 4/21/19.
//  Copyright © 2019 beescell. All rights reserved.
//

import UIKit


let brands = ["Mobiles","TVs","Air Conditions"]

let mobileImgs = ["3","3"]
let tvImgs = ["4","4","4","4","4","4"]
let airImgs = ["1","1","1"]


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            //banner cell
            return 170
            
        case 1,2,4:
            // brand cell
            return 185
            
        case 3:
            // offer cell
            return 195
            
        default:
            // brand cell
            return 44
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            //banner cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell", for: indexPath) as! BannerTableViewCell
            
            cell.bannerLabel.text = "50 %"
            cell.bannerImageView.image = UIImage(named: "1")
            
            return cell
            
        case 1,2,4:
            // brand cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandCell", for: indexPath) as! BrandTableViewCell
            
            if indexPath.row == 1 {
                //mobiles
                cell.categoryLabel.text = brands[0]
                cell.contentArr = mobileImgs
                
            }else if indexPath.row == 2 {
                //tvs
                cell.categoryLabel.text = brands[1]
                cell.contentArr = tvImgs
                
            }else {
                //air condition
                cell.categoryLabel.text = brands[2]
                cell.contentArr = airImgs
            }
            
            
            
            return cell
            
        case 3:
            // offer cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "OffersCell", for: indexPath) as! OffersTableViewCell
            cell.offerImageOne.image = UIImage(named: "2")
            cell.offerImageTwo.image = UIImage(named: "3")
            
            return cell
            
        default:
            // brand cell
            return UITableViewCell()
        }
        
    }
    
    
}

/*
 
 
 --------------------------------------
 
 banner
 
 ------------------------------------
 Mobiles
 ---------
 -
 -
 ---------
 -----------------------------------
 tvs
 ---------
 -
 -
 ---------
 -----------------------------------
 Offers
 ---------
 -
 -
 ---------
 -----------------------------------
 air conditions
 ---------
 -
 -
 ---------
 -----------------------------------
 
 
 
 
 
 
 */




