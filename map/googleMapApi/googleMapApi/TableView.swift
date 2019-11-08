//
//  TableView.swift
//  googleMapApi
//
//  Created by Ebrahim  Mo Gedamy on 9/6/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell", for: indexPath) as! PlacesCellVC
        
//        let placeObj = PlacesCellVC()
        if let lblPlaceName = cell.contentView.viewWithTag(102) as? UILabel {
            let place = self.resultPlaces[indexPath.row]
            lblPlaceName.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewPlaces.deselectRow(at: indexPath, animated: true)
        let place = self.resultPlaces[indexPath.row]
        if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
            if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
                if let latitude = location["lat"] as? Double {
                    if let longitude = location["lng"] as? Double {
                        UIApplication.shared.open(URL(string: "https://www.google.com/maps/@\(latitude),\(longitude),16z")!, options: [:])
                    }
                }
            }
        }
    }
    
}
