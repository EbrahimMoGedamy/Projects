//
//  ViewController.swift
//  mapBoxDemo
//
//  Created by Ebrahim  Mo Gedamy on 9/11/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxDirections
import MapboxNavigation

class ViewController: UIViewController , MGLMapViewDelegate {

    var mapView : NavigationMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.showsUserLocation = true
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "MyNavigationSegue":
            if let controller = segue.destination as? NavigationViewController {
                controller.route = route
                controller.directions = directions
            }
        default:
            break
        }
    }
}

