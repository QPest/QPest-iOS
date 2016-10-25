//
//  MonitoringLog.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//
// Monitoring log custom class

import UIKit
import CoreLocation

class MonitoringLog: NSObject {

    var date : Date = Date()
    var localization : CLLocation!
    var dateFormatted : String = String()
    var isNaturalEnemy : Bool = false
    var isPrague : Bool = false
    var pragueQuantity : Int = Int()
    var prague : Prague = Prague()
    var imageTaken : UIImage!

    func setFormattedDate(){
        self.dateFormatted = String(self.date.hour) + ":" + String(format: "%02d", self.date.minute)
    }

}
