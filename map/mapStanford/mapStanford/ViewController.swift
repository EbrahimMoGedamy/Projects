//
//  ViewController.swift
//  mapStanford
//
//  Created by Ebrahim  Mo Gedamy on 9/4/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {

//AIzaSyABHc1GC86vBK-azDGn5MhimTX3qE6WZjc
    @IBOutlet weak var myMapView: MKMapView!
    var locationManager = CLLocationManager()
    var sourceLocation = CLLocationCoordinate2D(latitude: 30.013056, longitude: 31.208853)
    var destinationLocation = CLLocationCoordinate2D(latitude: 30.044420, longitude: 31.235712)

    override func viewDidLoad() {
        super.viewDidLoad()
        myMapView.delegate = self
        myMapView.showsUserLocation = true
        myMapView.mapType = .standard
        
        self.checkLocationServices()
        

        
    }


}

extension ViewController : MKMapViewDelegate  {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {return nil}
        let annotiationView = MKAnnotationView(annotation: annotation
            , reuseIdentifier: "customAnnotiation")
        annotiationView.image = UIImage(named: "pin")
        annotiationView.canShowCallout = true
        return annotiationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotiation title = \(String (describing: view.annotation?.title!))")
    
    }
    
}


extension ViewController : CLLocationManagerDelegate  {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let region = MKCoordinateRegion(center: sourceLocation , span: MKCoordinateSpan(latitudeDelta: 0.0, longitudeDelta: 0.0))
        myMapView.setRegion(region, animated: true)
        let sPin = CustomPin(pinTitle: "Mansoura", pinSubTitle: "Egypt / El-Dakhalia", location: sourceLocation)
        //print("\(sourceLocation.latitude )\n \(sourceLocation.longitude)")
        let dPin = CustomPin(pinTitle: "Nasr City", pinSubTitle: "Cairo / El-Dakhalia", location: destinationLocation)
        myMapView.addAnnotation(sPin)
        myMapView.addAnnotation(dPin)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print(" we have getting error direction : \(String(describing: error))")
                }
                return
            }
            let route = directionResponse.routes[0]
            self.myMapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.myMapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        myMapView.delegate = self
       
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        render.strokeColor = UIColor.red
        render.strokeColor = UIColor.blue
        render.lineWidth = 3.0
        
        return render
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("unable to access your current location : \(error)")
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() == true{
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined || CLLocationManager.authorizationStatus() == .restricted {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }else{
            let alert = UIAlertController(title: "wwww", message: "Please, Turn On Your Location Services or Gps", preferredStyle: .alert)
            let action = UIAlertAction(title: "kkk", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
