//
//  MapConfigurationViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 18/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MapConfigurationViewController: UIViewController {
    
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    
    var range : Int = 0
    var type : Int = 0
    
    var mapType : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getCurrentMapType()
        self.getCurrentMapRange()
        
        self.setupNavigationBar()
        self.setupInitialValues()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentMapType(){
    
        self.mapType = ConfigurationStandards.defaultStandards.typeOfPrefferedMap
    }
    
    func getCurrentMapRange(){
    
        self.range = ConfigurationStandards.defaultStandards.valueOfPrefferedMapRange

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
    
}
