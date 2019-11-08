//
//  SearchDelegate.swift
//  map
//
//  Created by Ebrahim  Mo Gedamy on 9/7/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import Foundation
import MapKit

extension ViewController : UISearchBarDelegate {
    func searchBuPressed(_ searchBar : UISearchBar) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            activityIndicator.startAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            
            if response == nil {
                print("Error : \(String(describing: error))")
            }else{
                
                //                //Remove annotations
                //                let annotiations = self.myMapView.annotations
                //                self.myMapView.removeAnnotation(annotiations as! MKAnnotation)
                
                //Getting data
                let latitude = response!.boundingRegion.center.latitude
                let longitude = response!.boundingRegion.center.longitude
                
                //Create annotation
                let annotiation = MKPointAnnotation()
                annotiation.title = searchBar.text
                annotiation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self.myMapView.addAnnotation(annotiation)
                
                //Zooming in on annotation
                let coordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.myMapView.setRegion(region, animated: true)
                
                
                
            }
        }
        
        
    }

}

