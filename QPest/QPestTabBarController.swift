//
//  CartolaVIPTabBarController.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class QPestTabBarController: UITabBarController, CustomTabBarDataSource, CustomTabBarDelegate, UITabBarControllerDelegate  {
    
    let monitoringIcon = "monitoringIcon"
    let identificationIcon = "cameraIcon"
    let mapIcon = "mapIcon"
    
    // MARK: - Initializing view

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewControllers()
        
        // Do any additional setup after loading the view.

        self.tabBar.isHidden = true
        self.selectedIndex = 1
        self.delegate = self
        
        let customTabBar = CustomTabBar(frame: self.tabBar.frame)
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.setup()
        
        let identificationButton = customTabBar.tabBarButtons[1]
        customTabBar.barItemTapped(sender: identificationButton)
        
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
            monitoringView.tabBarItem.image = UIImage(named: self.monitoringIcon)
            
            viewControllers.append(monitoringView)
        }
        
        // second view controller

        if let identificationView = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "IdentificationStoryboard", identifier: ""){
            identificationView.tabBarItem.image = UIImage(named: self.identificationIcon)
            
            viewControllers.append(identificationView)
            
        }
        
        // third view controller
        
        if let mapView = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "MapStoryboard", identifier: ""){
            mapView.tabBarItem.image = UIImage(named: self.mapIcon)
            
            viewControllers.append(mapView)
        }
        

        //Adding views on tab bar
        self.viewControllers = viewControllers
    }
    
    
}
