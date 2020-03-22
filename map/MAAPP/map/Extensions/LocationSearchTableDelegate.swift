//
//  LocationSearchTableDelegate.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/9/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension LocationSearchTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = matchingPlaces[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion:  nil)
    }
    
}
