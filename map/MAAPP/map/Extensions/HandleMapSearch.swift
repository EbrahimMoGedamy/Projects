//
//  HandleMapSearch.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/9/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension ViewController : HandleMapSearch {
    
    
    func dropPinZoomIn(placemark: MKPlacemark) {
        
        // cache the pin
        selectedPin = placemark
        
        // clear existing pins
    
//        if let annotations = self.myMapView?.annotations {
//            for _annotation in annotations {
//                if let annotation = _annotation as? MKAnnotation
//                {
//                    self.myMapView.removeAnnotation(annotation)
//                }
//            }
//        }
        
        let annotiation = MKPointAnnotation()
        annotiation.coordinate = placemark.coordinate
        annotiation.title = placemark.name
        self.lat = placemark.coordinate.latitude
        self.long = placemark.coordinate.longitude
        print("\(self.long)\n\(self.lat)")
        
        if let city = placemark.locality ,
            let state = placemark.administrativeArea {
            annotiation.subtitle = "\(city) , \(state)"
            print(annotiation.subtitle)
        }
        DispatchQueue.main.async {
            self.myMapView.addAnnotation(annotiation)
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        myMapView.setRegion(region, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
}
