//
//  ViewController.swift
//  showPlacesOnMap
//
//  Created by Ebrahim  Mo Gedamy on 8/30/19.
//  Copyright © 2019 Ebrahim Mo Gedamy. All rights reserved.
//

import UIKit
import MapKit
class MapVC: UIViewController {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchBuPressed(_ sender: UIBarButtonItem) {
        
    }
    
}

extension ViewController : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
}

