//
//  ViewController.swift
//  searchTxtFieldNotSearchBar
//
//  Created by Ebrahim  Mo Gedamy on 3/6/20.
//  Copyright © 2020 Ebrahim  Mo Gedamy. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class ViewController: UIViewController , MKMapViewDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Search
    
    fileprivate var localSearchRequest: MKLocalSearch.Request!
    fileprivate var localSearch: MKLocalSearch!
    fileprivate var localSearchResponse: MKLocalSearch.Response!
    
    // MARK: - Map variables
    
    fileprivate var annotation : MKAnnotation!
    fileprivate var locationManager : CLLocationManager!
    fileprivate var isCurrentLocation : Bool = false
    var selectedPin : MKPlacemark? = nil
    var lat : Double?
    var long : Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        mapView.delegate = self
        mapView.mapType = .standard
    }
 
    func setUpSearchTxtField() {
        
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //This API call was introduced in iOS 9 and triggers a one-time location request
        locationManager.requestLocation()
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
    }
    
    @IBAction func txtFieldEditingChange(_ sender: UITextField) {
        
    }
    
}
// MARK: - CLLocationManagerDelegate

extension ViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !isCurrentLocation {
            return
        }
        
        isCurrentLocation = false
        
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = location!.coordinate
        pointAnnotation.title = ""
        mapView.addAnnotation(pointAnnotation)
    }
}

//
//class ViewController: UIViewController , MKMapViewDelegate , UITextFieldDelegate{
//
//    @IBOutlet weak var searchField: UITextField!
//    @IBOutlet weak var mapView: MKMapView!
//
//    // MARK: - Search
//
//    fileprivate var localSearchRequest: MKLocalSearch.Request!
//    fileprivate var localSearch: MKLocalSearch!
//    fileprivate var localSearchResponse: MKLocalSearch.Response!
//
//    // MARK: - Map variables
//
//    fileprivate var annotation : MKAnnotation!
//    fileprivate var locationManager : CLLocationManager!
//    fileprivate var isCurrentLocation : Bool = false
//    var selectedPin : MKPlacemark? = nil
//    var lat : Double?
//    var long : Double?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        searchField.delegate = self
//        mapView.delegate = self
//        mapView.mapType = .standard
//    }
//
//    @IBAction func txtFieldEditingChange(_ sender: UITextField) {
//        if (CLLocationManager.locationServicesEnabled()) {
//            if locationManager == nil {
//                locationManager = CLLocationManager()
//            }
//            locationManager?.requestWhenInUseAuthorization()
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestAlwaysAuthorization()
//            locationManager.startUpdatingLocation()
//            isCurrentLocation = true
//        }
//
//        if self.mapView.annotations.count != 0 {
//            annotation = self.mapView.annotations[0]
//            self.mapView.removeAnnotation(annotation)
//        }
//
//        localSearchRequest = MKLocalSearch.Request()
//        localSearchRequest.naturalLanguageQuery = self.searchField.text
//        localSearch = MKLocalSearch(request: localSearchRequest)
//        localSearch.start { [weak self] (localSearchResponse, error) -> Void in
//
//
//            let pointAnnotation = MKPointAnnotation()
//            pointAnnotation.title = self?.searchField.text
//            self?.lat = localSearchResponse?.boundingRegion.center.latitude
//            self?.long = localSearchResponse?.boundingRegion.center.longitude
//            print("/////")
//            print(self?.lat ?? 0.0)
//            print(self?.long ?? 0.0)
//            print("/////")
//            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
//
//            let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
//            self!.mapView.centerCoordinate = pointAnnotation.coordinate
//            self!.mapView.addAnnotation(pinAnnotationView.annotation!)
//        }
//
//    }
//
//}
//// MARK: - CLLocationManagerDelegate
//
//extension ViewController : CLLocationManagerDelegate{
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if !isCurrentLocation {
//            return
//        }
//
//        isCurrentLocation = false
//
//        let location = locations.last
//        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//
//        self.mapView.setRegion(region, animated: true)
//
//        if self.mapView.annotations.count != 0 {
//            annotation = self.mapView.annotations[0]
//            self.mapView.removeAnnotation(annotation)
//        }
//
//        let pointAnnotation = MKPointAnnotation()
//        pointAnnotation.coordinate = location!.coordinate
//        pointAnnotation.title = ""
//        mapView.addAnnotation(pointAnnotation)
//    }
//}
