//
//  MIPMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MIPMainViewController: UIViewController {

    var backgroundColorPassed : UIColor = UIColor()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColorPassed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
