//
//  QPestIOSUtil.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import Foundation
import UIKit

class QPestIOSUtil: NSObject {
        
    class func viewControllerFromStoryboardWithIdentifier(name:String, identifier:NSString)->UIViewController?{
        
        let storyboard : UIStoryboard = UIStoryboard(name: name, bundle: nil)
        
        if(!(identifier.isEqual(to: ""))){
            return storyboard.instantiateViewController(withIdentifier: identifier as String)
        }else{
            return storyboard.instantiateInitialViewController()!
        }
        
    }
    
    class func getViewControllerToShow()->UIViewController{
       
        if (QPestIOSUtil.checkIfUserAgreedTerms() == false){
            if let initialViewController = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "OnboardingStoryboard", identifier: ""){
                return initialViewController
            }
        }
        else{
        
            if let initialViewController = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "QPestTabBar", identifier: ""){
                return initialViewController
            }
        }
        
        return UIViewController()
        
    }
    
    class func setInitialStandards(){
        
        let defaults = UserDefaults.standard
        
        defaults.set(0, forKey: ConfigurationStandards.defaultStandards.keyForMapType)
        defaults.set(400, forKey: ConfigurationStandards.defaultStandards.keyForMapRange)
        
        ConfigurationStandards.defaultStandards.typeOfPrefferedMap = 0
        ConfigurationStandards.defaultStandards.valueOfPrefferedMapRange = 400
        
        
    }
    
    class func checkInitialConfigurations(){
    
        let defaults = UserDefaults.standard
    
        ConfigurationStandards.defaultStandards.typeOfPrefferedMap = defaults.integer(forKey: ConfigurationStandards.defaultStandards.keyForMapType)
        ConfigurationStandards.defaultStandards.valueOfPrefferedMapRange = defaults.integer(forKey: ConfigurationStandards.defaultStandards.keyForMapRange)
        
        // 
        
    }
    
    //MARK:Checks if the user has agreed with terms of us
    
    class func checkIfUserAgreedTerms()->Bool{
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "userAgreedTerms")
    }
    
    class func setUserAgreedTerms(status : Bool){
        let defaults = UserDefaults.standard
        defaults.set(status, forKey: "userAgreedTerms")
    }
    
    class func getRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}




