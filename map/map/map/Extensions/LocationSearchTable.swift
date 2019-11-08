//
//  LocationSearchTable.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/8/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import MapKit

extension LocationSearchTableVC : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //Set up the API call
        
        guard let mapView = mapView , let searchBarText = searchController.searchBar.text else {return}
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { (response, _) in
            guard let response = response else {return}
            
            self.matchingPlaces = response.mapItems
            self.tableView.reloadData()
        }
    }
    
//
//    func updateSearchResultsForSearchController(searchController : UISearchController) {
//
//
//    }
//
    
    
}
