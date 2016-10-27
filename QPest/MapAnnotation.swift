//
//  MapAnnotation.swift
//  QPest
//
//  Created by Danilo Mendes on 10/21/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    
    var myCoordinate: CLLocationCoordinate2D
    var title : String?
    
    init(_ myCoordinate: CLLocationCoordinate2D) {
        self.myCoordinate = myCoordinate
    }
    
    var coordinate: CLLocationCoordinate2D {
        return myCoordinate
    }
    
    var myTitle: String {
        if let title = self.title{
            return title
        }else{
            return ""
        }
    }
    
    
}
