//
//  MonitoringMapViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 25/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MonitoringMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var mapLocalization : CLLocation!
    var regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()

        self.centerMapOnLocation(location: self.mapLocalization)
        self.setupLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setupLocation(){
    
        self.mapView.centerCoordinate = self.mapLocalization.coordinate
        self.mapView.showsUserLocation = true
        self.mapView.userLocation.title = "Minha Localização"
        self.mapView.delegate = self
        
    }
    
    
    

}
