//
//  IdentificationMenuViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 18/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import CircleMenu

class IdentificationMenuViewController: UIViewController, CircleMenuDelegate {

    
    
    let items: [(icon: String, color: UIColor)] = [
        ("close", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
        ("close", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
        ("close", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
        ("close", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
        ("close", UIColor(red:1, green:0.39, blue:0, alpha:1)),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.configureCircleMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func configureCircleMenuButton(){
    
                let button = CircleMenu(
                    frame: CGRect(x: self.view.frame.width / 2 , y: self.view.frame.height / 2, width: 66, height: 66),
                    normalIcon:"identificationMenu",
                    selectedIcon:"close",
                    buttonsCount: 4,
                    duration: 1,
                    distance: 150)
                button.backgroundColor = UIColor.lightGray
                button.delegate = self
                button.layer.cornerRadius = button.frame.size.width / 2.0
                button.center = CGPoint(x: self.view.frame.width / 2 , y:  self.view.frame.height / 2)

                view.addSubview(button)
        
    }
  
    @IBAction func didClickBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    
    func didSelectMenuItem(index : Int){
    
        switch index {
        case 0:
            self.performSegue(withIdentifier: "goSurvey", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "", sender: nil)
        case 3:
            self.performSegue(withIdentifier: "", sender: nil)
        default: break
    
        }
    
    }
    
    // MARK: <CircleMenuDelegate>
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        //print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        //print("button did selected: \(atIndex)")
        self.didSelectMenuItem(index: atIndex)
    }
}
