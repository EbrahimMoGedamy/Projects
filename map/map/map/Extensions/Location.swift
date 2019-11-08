//
//  Location.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/7/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import MapKit

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            print("Location : \(location)")
//            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            myMapView.setRegion(region, animated: true)
//            
//            let desierdLocation = CLLocationCoordinate2D(latitude: 24.08893800, longitude: 32.89983000)
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = desierdLocation
//            annotation.title = "Aswan"
//            annotation.subtitle = "Egypt"
//            myMapView.addAnnotation(annotation)
//            
//        }
  }
//    
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : \(error)")
    }
}
