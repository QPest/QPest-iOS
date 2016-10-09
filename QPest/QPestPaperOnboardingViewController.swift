//
//  QPestPaperOnboardingViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 08/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import PaperOnboarding

class QPestPaperOnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate{

    @IBOutlet weak var continueButton: UIButton!
    
    var colors : [UIColor] = []

    var onboarding = PaperOnboarding(itemsCount: 5)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupColors()
        self.setupOnboarding()
        self.setupContinueButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupContinueButton(){
    
        self.view.bringSubview(toFront: self.continueButton)
        self.continueButton.layer.cornerRadius = 8
        self.continueButton.isHidden = true
        
    }
    
    private func setupColors(){
    
        self.colors = ColorPalette.defaultPalette.paperOnboardingColors
    }
    
    
    func setupOnboarding(){
    
        self.onboarding = PaperOnboarding(itemsCount: 4)
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
     
        let firstItem : OnboardingItemInfo = (imageName: "close", title: "Bem vindo ao QPest", description: "Arraste para saber mais", iconName: "close", color: self.colors[0], titleColor: UIColor.white, descriptionColor: UIColor.colorWithHexString(hex:"FAFAFA"), titleFont: UIFont(name: "Avenir-Medium", size: 35)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
      
        let secondItem : OnboardingItemInfo = (imageName: "close", title: "Praga, ou inimigo natural?", description: "O aplicativo do Qpest te permite facilmente identificar se o percevejo que você detectou é maléfico ou não. Basta apenas tirar uma foto do aparelho bocal do inseto, e o aplicativo faz o resto", iconName: "close", color: self.colors[1], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 27)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        
        let thirdItem : OnboardingItemInfo = (imageName: "close", title: "Ação, com informação", description: "Não é apenas com a detecção de uma praga que você deve tomar ações de imediato. Informe o aplicativo sobre a contagem das pragas, que ele irá retornar informações úteis sobre o que você deve fazer, e principalmente em quantidades corretas", iconName: "close", color: self.colors[2], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 27)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        
        let fourthItem : OnboardingItemInfo = (imageName: "close", title: "Monitoramento, automação e muito mais", description: "Aproveite as diversas funcionaldiades do QPest como o monitoramento de seu terreno através de mapas, notificações sobre corretos locais para manejo, e um histórico de seus monitoramento na palma de sua mão", iconName: "close", color: self.colors[3], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 18)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
  
          let finalItem : OnboardingItemInfo = (imageName: "close", title: "Comece já usar o QPest", description: "", iconName: "close", color: self.colors[0], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 28)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        return [firstItem, secondItem, thirdItem, fourthItem, finalItem][index]
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int){
    }
    
    func onboardingDidTransitonToIndex(_ index: Int){

        if self.onboarding.currentIndex == 4{
            self.continueButton.isHidden = false
        }
        
    }
    
    func onboardingItemsCount() -> Int {
        return 5
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {

    }
    @IBAction func didClickContune(_ sender: AnyObject) {
    
        self.performSegue(withIdentifier: "goTerms", sender: nil)
        
    }
}
