//
//  IdentificationResultViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class IdentificationResultViewController: UIViewController {

    @IBOutlet weak var imageTaken: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var imageRecieved : UIImage = UIImage()
    
    var didIdentifyImage : Bool = Bool()
    var pragueIdentified : Prague!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configueView()
        self.decision()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func configueView(){
        self.imageTaken.image = self.imageRecieved
    }
    
    func createNewLog(){
    
       // let newPrague = Prague()
       // let newMonitoringLog = MonitoringLog()
        
    }
    
    func decision(){
    
    }
}
