//
//  CartolaVIPTabBarController.swift
//  Cartola VIP
//
//  Created by Henrique Dutra on 14/07/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class QPestTabBarController: UITabBarController, CustomTabBarDataSource, CustomTabBarDelegate, UITabBarControllerDelegate  {
    
    let monitoringTitle = ""
    let identificationTitle = ""
    let mapTitle = ""
    
    let monitoringIcon = "monitoringIcon"
    let identificationIcon = "cameraIcon"
    let mapIcon = "mapIcon"
    
    // MARK: - Initializing view

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewControllers()
        
        // Do any additional setup after loading the view.

        self.tabBar.isHidden = true
        self.selectedIndex = 0
        self.delegate = self
        
        let customTabBar = CustomTabBar(frame: self.tabBar.frame)
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.setup()
        
        self.view.addSubview(customTabBar)
    }
    
    // MARK: - CustomTabBarDataSource
    
    func tabBarItemsInCustomTabBar(tabBarView: CustomTabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    
    // MARK: - CustomTabBarDelegate
    
    func didSelectViewController(tabBarView: CustomTabBar, atIndex index: Int) {
        self.selectedIndex = index
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTabAnimatedTransitioning()
    }
    
    // MARK: - View controllers initializations

    
    func initViewControllers(){
        
        var viewControllers : [UIViewController] = []

        // first view controller
        if let monitoringView = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "MonotoringStoryboard", identifier: ""){
            monitoringView.tabBarItem.title = self.monitoringTitle
            monitoringView.tabBarItem.image = UIImage(named: self.monitoringIcon)
            
            viewControllers.append(monitoringView)
        }
        
        // second view controller

        if let identificationView = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "IdentificationStoryboard", identifier: ""){
            identificationView.tabBarItem.title = "Identificação"
            identificationView.tabBarItem.image = UIImage(named: self.identificationIcon)
            
            viewControllers.append(identificationView)
            
        }
        
        // third view controller
        
        if let mapView = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "MapStoryboard", identifier: ""){
            mapView.tabBarItem.title = "Meu Terreno"
            mapView.tabBarItem.image = UIImage(named: self.mapIcon)
            
            viewControllers.append(mapView)
        }
        

        //Adding views on tab bar
        self.viewControllers = viewControllers
        self.selectedIndex = 1
    }
    
    
}
