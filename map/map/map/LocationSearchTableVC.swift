//
//  LocationSearchTableVC.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/8/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationSearchTableVC: UITableViewController {
    
    var matchingPlaces : [MKMapItem] = []
    var mapView: MKMapView? = nil
    
    var handleMapSearchDelegate:HandleMapSearch? = nil
    
    //Add the placemark address to get postal address
    //This method converts the placemark to a custom address format like: “4 Melrose Place, Washington DC”
    func parsingAdrress(selectedItem : MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil ) ? " " : " "
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            
            //city
            selectedItem.locality ?? "",
            secondSpace,
            
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
    
}
