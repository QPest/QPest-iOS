//
//  MonitoringAddLogViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 18/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import TextFieldEffects
import PaperSwitch
import CoreLocation

class MonitoringAddNewLogViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    let locationManager : CLLocationManager = CLLocationManager()
    var locationCoordinate : CLLocation = CLLocation(latitude: 0, longitude: 0)

    @IBOutlet weak var localizationImageView: UIView!
    @IBOutlet weak var localizationDescription: UILabel!
    @IBOutlet weak var localizationTitle: UILabel!
    @IBOutlet weak var paperSwitch: RAMPaperSwitch!
    
    @IBOutlet weak var quantityTextField: HoshiTextField!
    @IBOutlet weak var pragueTextField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        self.quantityTextField.delegate = self
        self.pragueTextField.delegate = self
        
        self.setupPaperSwitch()
        self.setuplocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickConfirmation(_ sender: AnyObject) {
        self.checkFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func checkFields(){

        var verification : Bool = false
        
        // Validating if the fiels are formatted
        if let _ = Int(self.quantityTextField.text!) {
            if (self.pragueTextField.text != ""){
                verification = true
            }
        }
        
        self.fieldAction(value: verification)

    }
    
    private func fieldAction(value : Bool){
    
        if value {
            self.createNewLog()

            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("didSaveNewLog"), object: nil)
        }
        else{
            self.putMessage()
        }
    }
    
    private func putMessage(){

        _ = SweetAlert().showAlert("Erro!", subTitle: "1 ou mais campos com erro", style: AlertStyle.none)
        
    }

    private func createNewLog(){
    
        let newLog = MonitoringLog()

        newLog.date = Date()
        newLog.prague.name = self.pragueTextField.text!
        newLog.pragueQuantity = Int(self.quantityTextField.text!)!
        newLog.setFormattedDate()
        
        if self.paperSwitch.isOn{
            newLog.localization = self.getLocalization()
        }
        
        MonitoringLogDataSource.defaultLogDataSource.addLog(log: newLog)
        
        self.dismissView()
    }
    
    func dismissView(){
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getLocalization() -> CLLocation{
        return self.locationCoordinate
    }
    
    private func setuplocation(){
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let newCoordinate = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        self.locationCoordinate = newCoordinate
        
    }
    
    private func setupPaperSwitch() {
        
        self.paperSwitch.isOn = true
        
        self.paperSwitch.animationDidStartClosure = {(onAnimation: Bool) in
            
            self.animateLabel(self.localizationTitle, onAnimation: onAnimation, duration: self.paperSwitch.duration)
            self.animateLabel(self.localizationDescription, onAnimation: onAnimation, duration: self.paperSwitch.duration)
        }
    }
    
    private func animateLabel(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: label, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            label.textColor = onAnimation ? UIColor.white : UIColor.colorWithHexString(hex: "1D1D26")
            }, completion:nil)
    }
}
