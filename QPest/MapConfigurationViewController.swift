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
    
    var mapType : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getCurrentMapType()
        
        self.setupNavigationBar()
        self.setupInitialValues()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentMapType(){
    
        self.mapType = 2
    }
    
    func setupNavigationBar(){
    
        self.navigationItem.title = "Configurações"
    }
    
    func setupInitialValues(){
        
        self.changeSliderLabel()
        self.changeSegmentControl()
        
    }
    
    private func changeSegmentControl(){
    
        self.mapTypeSegmentedControl.selectedSegmentIndex = self.mapType
    }

    private func changeSliderLabel(){
    
        self.sliderLabel.text = String(Int(self.slider.value))

    }

    @IBAction func sliderDidChange(_ sender: AnyObject) {
        self.changeSliderLabel()
    }

    @IBAction func typeDidChange(_ sender: AnyObject) {
        
    }

}
