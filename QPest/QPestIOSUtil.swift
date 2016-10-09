//
//  CartolaVIPIOSUtil.swift
//  Cartola VIP
//
//  Created by Henrique Dutra on 19/09/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import Foundation
import UIKit

class QPestIOSUtil: NSObject {
    
    class func viewControllerFromStoryboardWithIdentifier(name:NSString, identifier:NSString)->UIViewController?{
        if let storyboard : UIStoryboard = UIStoryboard(name: name as String, bundle: nil){
            if(!(identifier.isEqual(to: ""))){
                return storyboard.instantiateViewController(withIdentifier: identifier as String)
            }else{
                return storyboard.instantiateInitialViewController()!
            }
        }else{
            return nil
        }
        
    }
    
    class func getViewControllerToShow()->UIViewController{
       
        if (QPestIOSUtil.checkIfUserAgreedTerms() == false){
            if let initialViewController = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "OnboardingStoryboard", identifier: ""){
                return initialViewController
            }
        }
        else{
        
            if let initialViewController = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "QPestTabBarController", identifier: ""){
                return initialViewController
            }
        }
        
        return UIViewController()
        
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




