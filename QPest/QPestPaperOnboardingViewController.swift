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
    
    @IBOutlet weak var leftArrows: UIImageView!
    @IBOutlet weak var rightArrows: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    let duration = 1.1
    var colors : [UIColor] = []
    var onboarding = PaperOnboarding(itemsCount: 5)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupColors()
        self.setupOnboarding()
        self.setupContinueButton()
        self.configureArrows()
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
    
    func fadeIn(finished: Bool) {
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseInOut], animations: { self.leftArrows.alpha = 1
            self.rightArrows.alpha = 1
            } , completion: self.fadeOut)

}
    
    func fadeOut(finished: Bool) {
        UIView.animate(withDuration: self.duration, delay: 0, options: [.curveEaseInOut], animations: { self.leftArrows.alpha = 0.3
            self.rightArrows.alpha = 0.3
            } , completion: self.fadeIn)
        

    }

    func configureArrows(){
        
        // rotating left arrow accordingly
        self.leftArrows.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)
        
        // bringing arrows to front
        self.view.bringSubview(toFront: self.leftArrows)
        self.view.bringSubview(toFront: self.rightArrows)
        
        // setting inital hidden values
        self.leftArrows.isHidden = true
        self.rightArrows.isHidden = false
        
        // staring animations
        self.fadeOut(finished: true)
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

    private func manageArrows(indexValue : Int){
    
        switch indexValue {
        case 0:
            self.leftArrows.isHidden = true
            self.rightArrows.isHidden = false
        case 1:
            self.leftArrows.isHidden = false
            self.rightArrows.isHidden = false
        case 2:
            self.leftArrows.isHidden = false
            self.rightArrows.isHidden = false
        case 3:
            self.leftArrows.isHidden = false
            self.rightArrows.isHidden = false
        case 4:
            self.leftArrows.isHidden = false
            self.rightArrows.isHidden = true
        default:
            break
        }
        
    }

    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
     
        let firstItem : OnboardingItemInfo = (imageName: "onboarding1", title: "Bem vindo ao QPest", description: "Arraste para saber mais", iconName: "onboarding1", color: self.colors[0], titleColor: UIColor.white, descriptionColor: UIColor.colorWithHexString(hex:"FAFAFA"), titleFont: UIFont(name: "Avenir-Medium", size: 35)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
      
        let secondItem : OnboardingItemInfo = (imageName: "onboarding2", title: "Praga, ou inimigo natural?", description: "O aplicativo do Qpest te permite facilmente identificar se o percevejo que você detectou é maléfico ou não. Basta apenas tirar uma foto do aparelho bocal do inseto, e o aplicativo faz o resto", iconName: "onboarding2", color: self.colors[1], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 27)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        
        let thirdItem : OnboardingItemInfo = (imageName: "onboarding3", title: "Ação, com informação", description: "Não é apenas com a detecção de uma praga que você deve tomar ações de imediato. Informe o aplicativo sobre a contagem das pragas, que ele irá retornar informações úteis sobre o que você deve fazer, e principalmente em quantidades corretas", iconName: "onboarding3", color: self.colors[2], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 27)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        
        let fourthItem : OnboardingItemInfo = (imageName: "onboarding4", title: "Monitoramento, automação e muito mais", description: "Aproveite as diversas funcionaldiades do QPest como o monitoramento de seu terreno através de mapas, notificações sobre corretos locais para manejo, e um histórico de seus monitoramento na palma de sua mão", iconName: "onboarding4", color: self.colors[3], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 18)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
  
          let finalItem : OnboardingItemInfo = (imageName: "onboarding5", title: "Comece já usar o QPest", description: "", iconName: "onboarding5", color: self.colors[0], titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: UIFont(name: "Avenir-Medium", size: 28)!, descriptionFont: UIFont(name: "Avenir", size: 15)!)
        
        return [firstItem, secondItem, thirdItem, fourthItem, finalItem][index]
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int){
    }
    
    func onboardingDidTransitonToIndex(_ index: Int){

        if self.onboarding.currentIndex == 4{
            self.continueButton.isHidden = false
        }
        
        self.manageArrows(indexValue: onboarding.currentIndex)
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
