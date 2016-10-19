//
//  ColorPalette.swift
//  QPest
//
//  Created by Henrique Dutra on 08/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import Foundation
import UIKit

class ColorPalette: NSObject {
    
    static let defaultPalette = ColorPalette()
    
    let pragueTableViewColor = UIColor.colorWithHexString(hex: "E3625F")
    let naturalEnemyTableViewColor = UIColor.colorWithHexString(hex: "B8E986")
    
    let paperOnboardingColors : [UIColor] = [ UIColor.colorWithHexString(hex: "3CA95C"), UIColor.colorWithHexString(hex: "E67E22"), UIColor.colorWithHexString(hex: "3498DB"), UIColor.colorWithHexString(hex: "34495E")]

    let mipPaperOnboardingColors : [UIColor] = [ UIColor.colorWithHexString(hex: "3CA95C"), UIColor.colorWithHexString(hex: "E67E22"), UIColor.colorWithHexString(hex: "3498DB"),UIColor.colorWithHexString(hex: "E3625F"), UIColor.colorWithHexString(hex: "34495E")]
    

}
