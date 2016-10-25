//
//  MonitoringLog.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//
// Monitoring log custom class

import UIKit

class MonitoringLog: NSObject {

    var date : Date = Date()
    var localization : String = String()
    var dateFormatted : String = String()
    var isNaturalEnemy : Bool = false
    var isPrague : Bool = false
    var pragueQuantity : Int = Int()
    var prague : Prague = Prague()

}
