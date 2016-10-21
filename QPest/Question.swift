//
//  Question.swift
//  QPest
//
//  Created by Henrique Dutra on 21/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class Question: NSObject {

    var question_id : Int = Int()
    var title : String = String()
    var type : String = String()
    var options : [option] = []
    var optionChosen : Option = Option()
}
