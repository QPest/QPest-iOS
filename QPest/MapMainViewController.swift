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

class MapMainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var textFeedbackLabel: UILabel!
    @IBOutlet weak var overlayButton: UIButton!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    let mapTitle = "Meu Terreno"
    let locationManager = CLLocationManager()
    var locationCoordinate = CLLocation(latitude: 0, longitude: 0)
    var regionRadius: CLLocationDistance = 1000
    var mapType : Int = 0
    
    var annotations = [MKPointAnnotation]()
    var polygon : MKPolygon?
    var areaCoordinates = [MKPolygon]()
    
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
        
        self.addLongPressGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
      self.loadMap()
    }
    
    // MARK: Setup methods
    
    private func setupInitialView(){
        
        self.setupNavigationBar()
        
        self.dismissOverlayView()
        self.configureButtonAppearance()
        
        self.setupConfigurationIcon()
        self.setupActionToLocate()
        
        self.setupInitialText()
        
        mapView.centerCoordinate = self.locationCoordinate.coordinate
        mapView.showsUserLocation = true
        mapView.userLocation.title = "Minha Localização"
        mapView.delegate = self
    }
    
    private func setuplocation(){
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func loadMap(){
        
        self.setupRegionRadius()
        self.setupMapType()
        self.centerMapOnLocation(location: self.locationCoordinate)
    }
    
    private func setupNavigationBar(){
        
        self.navigationItem.title = self.mapTitle
    }
    
    private func setupActionToLocate(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MapMainViewController.didClickActionToLocate), for: .touchUpInside)
        button.setImage(UIImage(named: self.mapLocationIcon), for: .normal)
        self.actionToLocateButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = self.actionToLocateButton
    }
    
    private func setupActionToExitOverlay(){
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MapMainViewController.didClickActionToExitOverlay), for: .touchUpInside)
        button.setImage(UIImage(named: "back"), for: .normal)
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
    
    func setupInitialText(){
        self.textFeedbackLabel.text = self.feedbackText
    }
    
    // MARK: Gesture Recognizer
    
    func addLongPressGesture(){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(handleLongPress))
        longPressRecognizer.minimumPressDuration = 0.25
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    func handleLongPress(_ gestureRecognize: UIGestureRecognizer){
        if self.isInEditingMode {
            guard gestureRecognize.state == .began else {
                return
            }
            
            let touchPoint = gestureRecognize.location(in: self.mapView)
            let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            let currentAnnotation = MKPointAnnotation()
            
            currentAnnotation.title = "Point \(annotations.count)"
            currentAnnotation.coordinate = touchMapCoordinate
            mapView.addAnnotation(currentAnnotation)
            
            annotations.append(currentAnnotation)
            
            updateOverlay()
        }
    }
    
    // MARK: Buttons
    
    func configureButtonAppearance(){
        self.overlayButton.layer.cornerRadius = 5
    }
    
    func didClickActionToLocate(){
        
        self.showOverlayView()
        self.setupActionToExitOverlay()
        
    }
    
    func didClickActionToExitOverlay(){
        
        self.dismissOverlayView()
        self.setupActionToLocate()
        self.endEditing()
        
    }
    
    func didClickNotification(){
        
        self.performSegue(withIdentifier: "goConfigurationView", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Map help functions
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 didChange newState: MKAnnotationViewDragState,
                 fromOldState oldState: MKAnnotationViewDragState) {
        
        switch newState {
        case .starting:
            view.dragState = .dragging
            break
        case .ending, .canceling:
            view.dragState = .none
            break
        default:
            break
        }
    }
    
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var v : MKAnnotationView! = nil
        let ident = "bike"
        v = mapView.dequeueReusableAnnotationView(withIdentifier: ident)
        if v == nil {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: ident)
            //MyAnnotationView(annotation:annotation, reuseIdentifier:ident)
        }
        v.annotation = annotation
        v.isDraggable = true
        return v
    }
    
    */
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon{
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.black
            polygonView.lineWidth = 0.5
            polygonView.fillColor = UIColor.green
            polygonView.alpha = 0.3
            return polygonView
        }
        /*
        if self.isInEditingMode {
            if overlay is MKPolygon{
                let polygonView = MKPolygonRenderer(overlay: overlay)
                polygonView.strokeColor = UIColor.blue
                polygonView.lineWidth = 0.5
                
                return polygonView
            }
        } else{
            if areaCoordinates.count > 0 {
                for overlay in areaCoordinates {
                    let polygon = MKPolygonRenderer(overlay: overlay)
                    polygon.strokeColor = UIColor.black
                    polygon.fillColor = UIColor.blue
                    
                    return polygon
                }
            }
        }
         */
        return MKPolygonRenderer()
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

    @IBAction func didClickCenterMap(_ sender: AnyObject) {
    
        self.needingUpdate = true
    }
    
    @IBAction func didClickOverlayButton(_ sender: AnyObject) {
        
        self.dismissOverlayView()
        self.beginEditing()
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
    
    func updateOverlay(){
        if let polygon = self.polygon{
            mapView.remove(polygon)
        }
        
        self.polygon = nil
        
        if self.annotations.count >= 3 {
            let coordinates = annotations.map({ $0.coordinate })
            
            var hull = sortConvex(coordinates)
            
            let polygon = MKPolygon(coordinates: &hull, count: hull.count)
            mapView.add(polygon)
            
            self.polygon = polygon
            
        } else{
            print("Not enough vertex to draw a polygon")
        }
        
    }
    
    func sortConvex(_ input: [CLLocationCoordinate2D]) -> [CLLocationCoordinate2D] {
        
        func cross(P: CLLocationCoordinate2D,
                   A: CLLocationCoordinate2D,
                   B: CLLocationCoordinate2D) -> Double{
            let part1 = (A.longitude - P.longitude) * (B.latitude - P.latitude)
            let part2 = (A.latitude - P.latitude) * (B.longitude - P.longitude)
            
            return part1 - part2
        }
        
        let points = input.sorted(by: {$0.longitude == $1.longitude ? $0.latitude < $1.latitude : $0.longitude < $1.longitude})
        
        var lower : [CLLocationCoordinate2D] = []
        for p in points {
            while lower.count >= 2 && cross(P: lower[lower.count-2], A: lower[lower.count-1], B: p) <= 0 {
                lower.removeLast()
            }
            lower.append(p)
        }
        
        // Build upper hull
        var upper: [CLLocationCoordinate2D] = []
        for p in points.reversed() {
            while upper.count >= 2 && cross(P: upper[upper.count-2], A: upper[upper.count-1], B: p) <= 0 {
                upper.removeLast()
            }
            upper.append(p)
        }
        
        // Last point of upper list is omitted because it is repeated at the
        // beginning of the lower list.
        upper.removeLast()
        
        // Concatenation of the lower and upper hulls gives the convex hull.
        return (upper + lower)
    }
    func beginEditing(){
    
        // Start editing, createing shapes, etc
    
        self.isInEditingMode = true
    }
    
    func endEditing(){
        
        if let polygon = self.polygon{
            self.areaCoordinates.append(polygon)
            
            for polygon in areaCoordinates{
                mapView.add(polygon)
            }
            
            for annotation in self.annotations{
                mapView.removeAnnotation(annotation)
            }
            
            self.annotations = []
            
        }
        
        self.isInEditingMode = false
    }
    
    func showOverlayView(){
    
        self.overlayView.isHidden = false
    }
    
    func dismissOverlayView(){
    
        self.overlayView.isHidden = true

    }
}
