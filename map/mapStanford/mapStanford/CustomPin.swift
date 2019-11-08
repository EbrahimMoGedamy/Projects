//
//  CustomPin.swift
//  mapStanford
//
//  Created by Ebrahim  Mo Gedamy on 9/4/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import MapKit

class CustomPin: NSObject , MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle : String , pinSubTitle : String , location : CLLocationCoordinate2D) {
        self.subtitle = pinSubTitle
        self.title = pinTitle
        self.coordinate = location
    }
}
