//
//  Survey.swift
//  QPest
//
//  Created by Henrique Dutra on 21/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class Survey: NSObject {

    var survey_id : Int = Int()
    var questions : [Question] = []
    
    var title : String = String()
    var category : String = String()
    var descriptionText : String = String()
    
}
