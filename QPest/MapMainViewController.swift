//
//  MapMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 07/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapMainViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var overlayButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    let mapTitle = "Meu Terreno"
    let locationManager = CLLocationManager()
    var locationCoordinate = CLLocation(latitude: 0, longitude: 0)
    let regionRadius: CLLocationDistance = 1000
    
    var configurationButton : UIBarButtonItem = UIBarButtonItem()
    var actionToLocateButton : UIBarButtonItem = UIBarButtonItem()
    let configurationIcon = "configIcon"
    let mapLocationIcon = "map-location"
    
    var needingUpdate : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissOverlayView()
        self.configureButtonAppearance()
        
        self.setuplocation()
        self.setupNavigationBar()
        self.setupConfigurationIcon()
        self.setupActionToLocate()
    
        self.centerMapOnLocation(location: self.locationCoordinate)

    }
    
    func configureButtonAppearance(){
    
        self.overlayButton.layer.cornerRadius = 5
    
    }
    
    
    func didClickActionToLocate(){
        
        self.showOverlayView()
        self.beginEditing()
        
    }
    
    private func setupActionToLocate(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MapMainViewController.didClickActionToLocate), for: .touchUpInside)
        button.setImage(UIImage(named: self.mapLocationIcon), for: .normal)
        self.actionToLocateButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = self.actionToLocateButton
        
    }
    
    private func setupConfigurationIcon(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MapMainViewController.didClickNotification), for: .touchUpInside)
        button.setImage(UIImage(named: self.configurationIcon), for: .normal)
        self.configurationButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = self.configurationButton
        
    }
    
    func didClickNotification(){
        
        self.performSegue(withIdentifier: "goConfigurationView", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationBar(){
        
        self.navigationItem.title = self.mapTitle
    }

    private func setuplocation(){
    
        locationManager.requestAlwaysAuthorization()

        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func didClickCenterMap(_ sender: AnyObject) {
    
        self.needingUpdate = true
//        self.centerMapOnLocation(location: self.locationCoordinate)
    }
    
    @IBAction func didClickOverlayButton(_ sender: AnyObject) {
        
        self.dismissOverlayView()
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let newCoordinate = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        self.locationCoordinate = newCoordinate
        
        if self.needingUpdate{
            self.centerMapOnLocation(location: self.locationCoordinate)
            self.needingUpdate = false
        }
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func beginEditing(){
    
        // Start editing, createing shapes, etc
    }
    
    func showOverlayView(){
    
        self.overlayView.isHidden = false
    }
    
    func dismissOverlayView(){
    
        self.overlayView.isHidden = true

    }
    
}
