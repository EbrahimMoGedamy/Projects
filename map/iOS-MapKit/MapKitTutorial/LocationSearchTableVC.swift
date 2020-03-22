//
//  LocationSearchTableVC.swift
//  MapKitTutorial
//
//  Created by Ebrahim  Mo Gedamy on 3/6/20.
//  Copyright © 2020 Maxim Bilan. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableVC: UIViewController , UISearchResultsUpdating {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    var matchingPlaces : [MKMapItem] = []
    var mapView: MKMapView? = nil
    var handleMapSearchDelegate : HandleMapSearch? = nil
    
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
        }
    }
}
extension LocationSearchTableVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchTVCell") as? LocationSearchTVCell{
            let selectedItem = matchingPlaces[indexPath.row].placemark
            cell.title.text = selectedItem.name
            cell.subTitle?.text = parsingAdrress(selectedItem: selectedItem)
            return cell
        }else{
            return LocationSearchTVCell()
        }
    }
}

extension LocationSearchTableVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingPlaces[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion:  nil)
    }
}
class LocationSearchTVCell: UITableViewCell {
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var title: UILabel!
}
