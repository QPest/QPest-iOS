//
//  ConfigurationStandards.swift
//  QPest
//
//  Created by Henrique Dutra on 18/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ConfigurationStandards: NSObject {

    static let defaultStandards = ConfigurationStandards()

    let keyForMapType : String = "QPestMapType"
    let keyForMapRange : String = "QPestMapRange"
    
    var typeOfPrefferedMap : Int = 0
    var valueOfPrefferedMapRange : Int = 0
    
    func changeMapType(value : Int){
    
        let defaults = UserDefaults.standard

        self.typeOfPrefferedMap = value
        defaults.set(value, forKey: ConfigurationStandards.defaultStandards.keyForMapType)

    }
    
    func changeMapRange(value : Int){

        let defaults = UserDefaults.standard

        self.valueOfPrefferedMapRange = value
        defaults.set(value, forKey: ConfigurationStandards.defaultStandards.keyForMapRange)
        
    }
    
}
