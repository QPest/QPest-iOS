//
//  IdentificationManualViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class IdentificationManualViewController: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()

        self.setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationBar(){
    
        self.navigationItem.title = "Manual de Identificação"
        
    }
}
