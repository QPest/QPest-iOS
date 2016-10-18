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

    let mapTitle = "Meu Terreno"
    let locationManager = CLLocationManager()
    var locationCoordinate = CLLocation(latitude: 37.785834, longitude: -122.406417)
    let regionRadius: CLLocationDistance = 1000

    var configurationButton : UIBarButtonItem = UIBarButtonItem()
    let configurationIcon = "configIcon"
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setuplocation()
        self.setupNavigationBar()
        self.setupConfigurationIcon()
    
        self.centerMapOnLocation(location: self.locationCoordinate)

    }
    
    private func setupConfigurationIcon(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MonitoringMainViewController.didClickNotification), for: .touchUpInside)
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
    }
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        self.locationCoordinate.coordinate.latitude = locValue.latitude
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
