//
//  MapVC.swift
//  mapDemo
//
//  Created by Ebrahim  Mo Gedamy on 8/24/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapPin: UIImageView!
    @IBOutlet weak var addressLbl: UILabel!
    var previousLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkLocationServices()
        mapView.mapType = .satellite
        mapView.delegate = self
    }
    
    func setupLocationManager() {
        // set delegate
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            // setup our location manager
            self.setupLocationManager()
            self.checkLocationAuth()
        }else{
            // notifiy user to turn on location
        }
    }
    
    func centerViewUserLocation() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 24.088938, longitudinalMeters: 32.899830)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuth() {
        switch CLLocationManager.authorizationStatus() {
       
            case .authorizedWhenInUse:
            //do map stuff
               self.startTrackingUserLocation()
            break
        case .denied:
            // show alert instruction them hoe to turn permissions
            break
        case .notDetermined :
            locationManager.requestWhenInUseAuthorization()
            break
       
         case .restricted:
            // show an alert showing them know what is up
            break
            
        case .authorizedAlways:
            //do map stuff
            break
     
        }
    }
    
    func startTrackingUserLocation(){
        mapView.showsUserLocation = true
        self.centerViewUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for mapView : MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}

extension MapVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.checkLocationAuth()
    }
}

extension MapVC : MKMapViewDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude , longitude:location.coordinate.longitude )
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 24.088938, longitudinalMeters: 32.899830)
//        mapView.setRegion(region, animated: true)
//    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = self.getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return}
        guard center.distance(from: previousLocation) > 50 else {return}
        self.previousLocation = center
        geoCoder.reverseGeocodeLocation(center){ [weak self] (placeMark , error) in
            guard self != nil else { return }
            
            if let _ = error{
                // TODO : Show alert info for user
                return
            }
            guard let placeMark = placeMark?.first else {
                // TODO : Show alert info for user
                return
            }
            
            let streetNumber = placeMark.subThoroughfare ?? ""
            let streetName = placeMark.subThoroughfare ?? ""
            
            DispatchQueue.main.async {
                self?.addressLbl.text = ("\(streetNumber)  \(streetName)")
            }
        }
    }
}
