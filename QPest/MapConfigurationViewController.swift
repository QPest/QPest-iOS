//
//  MapConfigurationViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 18/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import PaperSwitch

class MapConfigurationViewController: UIViewController {
    
    @IBOutlet weak var connectContactsLabel: UILabel!
    @IBOutlet weak var phone1ImageView: UIImageView!
    @IBOutlet weak var paperSwitch1: RAMPaperSwitch!
    
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    
    var range : Int = 0
    var type : Int = 0
    var ground : Bool = true
    
    var mapType : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getConfigurationStandardsForMap()
        
        self.setupNavigationBar()
        self.setupInitialValues()
        
        self.setupPaperSwitch()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getConfigurationStandardsForMap(){
    
        self.mapType = ConfigurationStandards.defaultStandards.typeOfPrefferedMap
        self.range = ConfigurationStandards.defaultStandards.valueOfPrefferedMapRange
        self.ground = ConfigurationStandards.defaultStandards.prefferedVisualizationOfGround
    }
    
    func setupNavigationBar(){
    
        self.navigationItem.title = "Configurações"
    }
    
    func setupInitialValues(){
        
        self.changeSliderValue(value: self.range)
        self.changeSliderLabel(value: String(Int(self.slider.value)))
        self.changeSegmentControl()
        
    }
    
    private func changeSegmentControl(){
        self.mapTypeSegmentedControl.selectedSegmentIndex = self.mapType
    }

    private func changeSliderLabel(value: String){
        self.sliderLabel.text = value
    }
    
    private func changeSliderValue(value: Int){
        self.slider.value = Float(value)
    }

    @IBAction func sliderDidChange(_ sender: AnyObject) {
        self.changeSliderLabel(value: String(Int(self.slider.value)))
        self.didChangeMapRange()
    }

    @IBAction func typeDidChange(_ sender: AnyObject) {

        self.didChangeMapType()

    }

    func didChangeMapType(){
    
        ConfigurationStandards.defaultStandards.changeMapType(value: self.mapTypeSegmentedControl.selectedSegmentIndex)
    }
    
    func didChangeMapRange(){
        
        ConfigurationStandards.defaultStandards.changeMapRange(value: Int(self.slider.value))
    }
    
    func didChangeMapGround(){
        
        ConfigurationStandards.defaultStandards.changeMapGround(value: self.paperSwitch1.isOn)
    }
    
   private func setupPaperSwitch() {
    
        self.paperSwitch1.isOn = self.ground
        self.paperSwitch1.animationDidStartClosure = {(onAnimation: Bool) in
            
            self.animateLabel(self.connectContactsLabel, onAnimation: onAnimation, duration: self.paperSwitch1.duration)
            self.animateImageView(self.phone1ImageView, onAnimation: onAnimation, duration: self.paperSwitch1.duration)
        }
        
    }
    
    private func animateLabel(_ label: UILabel, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: label, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            label.textColor = onAnimation ? UIColor.white : UIColor.colorWithHexString(hex: "3CA95C")
            self.didChangeMapGround()
            }, completion:nil)
    }
    
    private func animateImageView(_ imageView: UIImageView, onAnimation: Bool, duration: TimeInterval) {
        UIView.transition(with: imageView, duration: duration, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            imageView.image = UIImage(named: onAnimation ? "phone_on" : "phone_off")
            }, completion:nil)
    }

    
}
