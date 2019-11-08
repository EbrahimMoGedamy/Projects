//
//  ViewController.swift
//  googleMapApi
//
//  Created by Ebrahim  Mo Gedamy on 9/6/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewPlaces: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    var resultPlaces : [Dictionary<String,AnyObject>] = Array( )
    //    var sourceLocation = CLLocationCoordinate2D(latitude: 31.040949, longitude: 31.378469)
    //
    override func viewDidLoad() {
        //        super.viewDidLoad()
        //        // Do any additional setup after loading the view.
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(self.searchPlacesFromGoogleMap(_:)), for: .editingChanged)
        tableViewPlaces.estimatedRowHeight = 44.0
        //
        //        // Create a GMSCameraPosition that tells the map to display the
        //        // coordinate -33.86,151.20 at zoom level 6.
        //        let camera = GMSCameraPosition.camera(withTarget: sourceLocation, zoom: 15.0)
        //        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //        view = mapView
        //
        //        // Creates a marker in the center of the map.
        //        let marker = GMSMarker()
        //        marker.position = sourceLocation
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
        //        marker.map = mapView
    }
    
    
}

extension ViewController : UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.searchPlacesFromGoogleMap(place: textField.text!)
//        return true
//    }
    
    
    @objc func searchPlacesFromGoogleMap(_ textField:UITextField) {
        
        if let searchQuery = textField.text {

        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?query\(searchQuery)&key=AIzaSyC-5ApV5WKSSOjQsMlAT8QVulgE3JTZYxg"
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                 if let responseData = data {
                let dataJson = try? JSONSerialization.jsonObject(with: responseData , options: .mutableContainers)
                 
                     if let dict = dataJson as? Dictionary<String, AnyObject>{
                         if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                print("json == \(results)")
                            self.resultPlaces.removeAll()
                            for dct in results {
                                self.resultPlaces.append(dct)
                            }
                            DispatchQueue.main.async {
                                self.tableViewPlaces.reloadData()
                            }
                            
                        }
                    }
                    
                }
                
            }else{
                
            }
        }
        task.resume()
        }
    }
}

