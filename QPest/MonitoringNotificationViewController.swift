//
//  MonitoringNotificationViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 08/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MonitoringNotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(_ sender: AnyObject) {
    
        self.dismiss(animated: true, completion: nil)
    }

}

