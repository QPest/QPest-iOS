//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Framework for custom tab bar architecture and animation

import UIKit

protocol CustomTabBarDataSource {
    func tabBarItemsInCustomTabBar(tabBarView: CustomTabBar) -> [UITabBarItem]
}

protocol CustomTabBarDelegate {
    func didSelectViewController(tabBarView: CustomTabBar, atIndex index: Int)
}

class CustomTabBar: UIView {
    
    var datasource: CustomTabBarDataSource!
    var delegate: CustomTabBarDelegate!
    
    var tabBarItems: [UITabBarItem]!
    var customTabBarItems: [CustomTabBarItem]!
    var tabBarButtons: [UIButton]!
    
    var initialTabBarItemIndex: Int!
    var selectedTabBarItemIndex: Int!
    var slideMaskDelay: Double!
    var slideAnimationDuration: Double!
    
    var tabBarItemWidth: CGFloat!
    var leftMask: UIView!
    var rightMask: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // get tab bar items from default tab bar
        tabBarItems = datasource.tabBarItemsInCustomTabBar(tabBarView: self)
        
        customTabBarItems = []
        tabBarButtons = []
        
        initialTabBarItemIndex = 0
        selectedTabBarItemIndex = initialTabBarItemIndex
        
        slideAnimationDuration = 0.6
        slideMaskDelay = slideAnimationDuration / 2
        
        let containers = createTabBarItemContainers()
        
        createTabBarItemSelectionOverlay(containers: containers)
        createTabBarItemSelectionOverlayMask(containers: containers)
        createTabBarItems(containers: containers)
    }
    
    func createTabBarItemSelectionOverlay(containers: [CGRect]) {
        
        _ = [UIColor.white, UIColor.white, UIColor.white,UIColor.white,UIColor.white]
        
        for index in 0..<tabBarItems.count {
            let container = containers[index]
            
            let view = UIView(frame: container)
            
            let selectedItemOverlay = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            selectedItemOverlay.backgroundColor = UIColor.colorWithHexString(hex: "F2F2F2")
            UIColor.lightGray.withAlphaComponent(0.13)
            view.addSubview(selectedItemOverlay)
            
            self.addSubview(view)
        }
    }
    
    func createTabBarItemSelectionOverlayMask(containers: [CGRect]) {
        
        tabBarItemWidth = self.frame.width / CGFloat(tabBarItems.count)
        let leftOverlaySlidingMultiplier = CGFloat(initialTabBarItemIndex) * tabBarItemWidth
        let rightOverlaySlidingMultiplier = CGFloat(initialTabBarItemIndex + 1) * tabBarItemWidth
        
        leftMask = UIView(frame: CGRect(x: 0, y: 0, width: leftOverlaySlidingMultiplier, height: self.frame.height))
        leftMask.backgroundColor = UIColor.white
        rightMask = UIView(frame: CGRect(x: rightOverlaySlidingMultiplier, y: 0, width: tabBarItemWidth * CGFloat(tabBarItems.count - 1), height: self.frame.height))
        rightMask.backgroundColor = UIColor.white
        
        self.addSubview(leftMask)
        self.addSubview(rightMask)
    }
    
    func createTabBarItems(containers: [CGRect]) {
        
        var index = 0
        for item in tabBarItems {
            
            let container = containers[index]
            
            let customTabBarItem = CustomTabBarItem(frame: container)
            customTabBarItem.setup(item: item)
            
            self.addSubview(customTabBarItem)
            customTabBarItems.append(customTabBarItem)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: container.width, height: container.height))
            button.addTarget(self, action: #selector(CustomTabBar.barItemTapped), for: UIControlEvents.touchUpInside)
            
            customTabBarItem.addSubview(button)
            tabBarButtons.append(button)
            
            index += 1
            
        }
        
        self.customTabBarItems[initialTabBarItemIndex].iconView.tintColor = UIColor.blue
    }
    
    func createTabBarItemContainers() -> [CGRect] {
        
        var containerArray = [CGRect]()
        
        // create container for each tab bar item
        for index in 0..<tabBarItems.count {
            let tabBarContainer = createTabBarContainer(index: index)
            containerArray.append(tabBarContainer)
        }
        
        return containerArray
    }
    
    func createTabBarContainer(index: Int) -> CGRect {
        
        let tabBarContainerWidth = self.frame.width / CGFloat(tabBarItems.count)
        let tabBarContainerRect = CGRect(x: tabBarContainerWidth * CGFloat(index), y: 0, width: tabBarContainerWidth, height: self.frame.height)
        
        return tabBarContainerRect
    }
    
    func animateTabBarSelection(from: Int, to: Int){
        
        let overlaySlidingMultiplier = CGFloat(to - from) * tabBarItemWidth
        
        let leftMaskDelay: Double
        let rightMaskDelay: Double
        if overlaySlidingMultiplier > 0 {
            leftMaskDelay = slideMaskDelay
            rightMaskDelay = 0
        }
        else {
            leftMaskDelay = 0
            rightMaskDelay = slideMaskDelay
        }
        
        UIView.animate(withDuration: slideAnimationDuration - leftMaskDelay, delay: leftMaskDelay, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.leftMask.frame.size.width += overlaySlidingMultiplier
            }, completion: nil)
        
        UIView.animate(withDuration: slideAnimationDuration - rightMaskDelay, delay: rightMaskDelay, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.rightMask.frame.origin.x += overlaySlidingMultiplier
            self.rightMask.frame.size.width += -overlaySlidingMultiplier
            self.customTabBarItems[from].iconView.tintColor = UIColor.black
            self.customTabBarItems[to].iconView.tintColor = UIColor.blue
            }, completion: nil)
        
    }
    
    func barItemTapped(sender : UIButton) {
        let index = tabBarButtons.index(of: sender)!
        
        animateTabBarSelection(from: selectedTabBarItemIndex, to: index)
        selectedTabBarItemIndex = index
        delegate.didSelectViewController(tabBarView: self, atIndex: index)
    }
}
