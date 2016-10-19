//
//  MIPMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import PaperOnboarding

class MIPMainViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {

    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var beginButton: UIButton!
    
    var backgroundColorPassed : UIColor = UIColor()
    var onboarding = PaperOnboarding(itemsCount: 6)
    var colors : [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupColors()
        self.view.backgroundColor = backgroundColorPassed
        self.beginButton.layer.cornerRadius = 5
        
        self.setupContinueButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickEndMIPDemo(_ sender: AnyObject) {
   
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func didClickBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didClickBegin(_ sender: AnyObject) {
        self.putOnboardingOnScreen()
    }
    
    private func setupContinueButton(){
        
        self.view.bringSubview(toFront: self.continueButton)
        self.continueButton.layer.cornerRadius = 8
        self.continueButton.isHidden = true
        
    }
    
    func putOnboardingOnScreen(){
    
        self.setupOnboarding()
        
    }
    
    private func setupColors(){
        
        self.colors = ColorPalette.defaultPalette.mipPaperOnboardingColors
    }
    
    
    func setupOnboarding(){
        
        self.onboarding = PaperOnboarding(itemsCount: 6)
        onboarding.dataSource = self
        onboarding.delegate = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
        
    }
    
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        
        let firstItem : OnboardingItemInfo = (imageName: "onboarding1", title: "MIP", description: "Manejo integrado de pragas", iconName: "onboarding1", color: self.colors[0], titleColor: UIColor.white, descriptionColor: UIColor.colorWithHexString(hex:"FAFAFA"), titleFont: UIFont(name: "Avenir-Medium", size: 35)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        let secondItem : OnboardingItemInfo = (imageName: "onboarding2", title: "Tudo é técnica", description: "Sistema de manejo de pragas que associa o ambiente e a dinâmica populacional            da praga. Utiliza de todas as técnicas apropriadas para manter níveis abaixo daqueles capazes de causar danos econômicos", iconName: "onboarding2", color: self.colors[1], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 27)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        
        let thirdItem : OnboardingItemInfo = (imageName: "basesMIP", title: "As bases do MIP", description: "Confira a imagem", iconName: "onboarding3", color: self.colors[2], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 27)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        
        let fourthItem : OnboardingItemInfo = (imageName: "onboarding4", title: "Monitoramento", description: "Lorem Ipsum", iconName: "onboarding4", color: self.colors[3], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 18)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        let fifthItem : OnboardingItemInfo = (imageName: "onboarding4", title: "Tomada de decisão", description: "Lorem Ipsum", iconName: "onboarding4", color: self.colors[4], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 18)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        let finalItem : OnboardingItemInfo = (imageName: "onboarding5", title: "Quer saber mais?", description: "Acesse embrapa.br", iconName: "onboarding5", color: self.colors[0], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 28)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        return [firstItem, secondItem, thirdItem, fourthItem, fifthItem, finalItem][index]
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int){
    }
    
    func onboardingDidTransitonToIndex(_ index: Int){
        
        self.view.bringSubview(toFront: self.continueButton)

        if self.onboarding.currentIndex == 5{
            self.continueButton.isHidden = false
        }
    }
    
    func onboardingItemsCount() -> Int {
        return 6
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    
}
