//
//  MapViewDelegate.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/10/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension ViewController : MKMapViewDelegate {
    
    
    //customizes the appearance of map pins and callouts
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        
        var pinView  = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)  as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        pinView?.tintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "map-car"), for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        
        pinView?.leftCalloutAccessoryView = button
        
        return pinView
    }
    
}
