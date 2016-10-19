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
    
    @IBOutlet weak var textFeedbackLabel: UILabel!
    @IBOutlet weak var overlayButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    let mapTitle = "Meu Terreno"
    let locationManager = CLLocationManager()
    var locationCoordinate = CLLocation(latitude: 0, longitude: 0)
    var regionRadius: CLLocationDistance = 1000
    var mapType : Int = 0
    
    var configurationButton : UIBarButtonItem = UIBarButtonItem()
    var actionToLocateButton : UIBarButtonItem = UIBarButtonItem()
    let configurationIcon = "configIcon"
    let mapLocationIcon = "map-location"
    
    var needingUpdate : Bool = true
    
    let feedbackText : String = "Texto explicando como alterar"
    
    var isInEditingMode : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupInitialView()
        
        self.setuplocation()
        self.loadMap()
        
        self.centerMapOnLocation(location: self.locationCoordinate)

    }
    
    override func viewDidAppear(_ animated: Bool) {
      self.loadMap()
    }
    
    func loadMap(){
    
        self.setupRegionRadius()
        self.setupMapType()
        self.centerMapOnLocation(location: self.locationCoordinate)
    }
    
    private func setupInitialView(){
        
        self.setupNavigationBar()

        self.dismissOverlayView()
        self.configureButtonAppearance()
        
        self.setupConfigurationIcon()
        self.setupActionToLocate()
        
        self.setupInitialText()

        mapView.centerCoordinate = self.locationCoordinate.coordinate
    }
    
    func setupInitialText(){
        self.textFeedbackLabel.text = self.feedbackText
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

    private func setupRegionRadius(){
    
         self.regionRadius = CLLocationDistance(ConfigurationStandards.defaultStandards.valueOfPrefferedMapRange)
    }
    
    private func setupMapType(){
    
        self.mapType = ConfigurationStandards.defaultStandards.typeOfPrefferedMap
        
        switch (self.mapType) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default: // or case 2
            mapView.mapType = .standard
        }
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
    
        self.isInEditingMode = true
        
    }
    
    func endEditing(){
    
        self.isInEditingMode = false
    }
    
    func showOverlayView(){
    
        self.overlayView.isHidden = false
    }
    
    func dismissOverlayView(){
    
        self.overlayView.isHidden = true

    }
}
