//
//  ViewController.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/7/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

//////////////////SOURCE ===>> "https://www.thorntech.com/2016/01/how-to-search-for-location-using-apples-mapkit/"///////
import UIKit
import MapKit


//Drop a Map Pin and create a callout button
//create a special job duty, or protocol, for the map controller. This role has just one responsibility, which is to drop a pin on the map
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class ViewController: UIViewController  {
    
    @IBOutlet weak var myMapView: MKMapView!
    var selectedPin:MKPlacemark? = nil
    var lat : Double?
    var long : Double?
    
    //This variable has controller-level scope to keep the UISearchController in memory after it’s created.
    var resultSearchController:UISearchController? = nil
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpSearchController()
 
    }
    //        @IBAction func searchBu(_ sender: Any) {
    //            let searchController = UISearchController(searchResultsController: nil)
    //            searchController.searchBar.delegate = self as UISearchBarDelegate
    //            present(searchController, animated: true, completion: nil)
    //        }
    
    
    func setUpSearchController() {
        
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //This API call was introduced in iOS 9 and triggers a one-time location request
        locationManager.requestLocation()
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "locationSearchTable") as! LocationSearchTableVC
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        
        //Set up the search bar
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        //Configure the UISearchController appearance
        
        // determines whether the Navigation Bar disappears when the search results are shown. Set this to false, since we want the search bar accessible at all times.
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        
        // gives the modal overlay a semi-transparent background when the search bar is selected.
        //resultSearchController?.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        locationSearchTable.mapView = myMapView
        
        locationSearchTable.handleMapSearchDelegate = self
        
        
    }
    
    
    @objc func getDirections() {
        
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            
            //API call that launches the Apple Maps app with driving directions.
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
}

