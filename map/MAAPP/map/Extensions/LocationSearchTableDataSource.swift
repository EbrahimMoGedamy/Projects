//
//  LocationSearchTableDataSource.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/9/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension LocationSearchTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingPlaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationsCell")!
        let selectedItem = matchingPlaces[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parsingAdrress(selectedItem: selectedItem)
        
        return cell
    }
    
   
}
