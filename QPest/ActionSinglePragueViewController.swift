//
//  ActionSinglePragueViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ActionSinglePragueViewController: UIViewController {

    @IBOutlet weak var pragueTitle: UILabel!
    var pragueSelcted : Prague = Prague()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pragueTitle.text = pragueSelcted.name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickExit(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
