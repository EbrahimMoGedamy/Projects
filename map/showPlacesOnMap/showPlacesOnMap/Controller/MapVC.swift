//
//  MapVC.swift
//  showPlacesOnMap
//
//  Created by Ebrahim  Mo Gedamy on 8/30/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import CoreLocation

class MapVC: UIViewController {
    
    @IBOutlet weak var myMapView: MKMapView!
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRaduis = 1000.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        myMapView.delegate = self
        self.configureLocationServices()
    }

    
    @IBAction func mapViewBuPressed(_ sender: UIButton) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            self.centerUserLocation()
        }
        
    }
    
}

extension MapVC : MKMapViewDelegate{
    func centerUserLocation ( ){
        guard let coordinates = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: regionRaduis * 2.0, longitudeDelta: regionRaduis * 2.0))
        myMapView.setRegion(coordinateRegion, animated: true)
        
    }
}

extension MapVC : CLLocationManagerDelegate{
    
    func configureLocationServices() {
        if authorizationStatus == .notDetermined  {
            locationManager.requestAlwaysAuthorization()
        }else{return}
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.centerUserLocation()
    }
}

