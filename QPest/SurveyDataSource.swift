//
//  SurveyDataSource.swift
//  QPest
//
//  Created by Henrique Dutra on 21/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class SurveyDataSource: NSObject {

    static let defaultSurveyDataSource = SurveyDataSource()

    var surveys : [Survey] = []
    
    override init(){
        super.init()
        
        self.getInitalSurveys()
    }
    
    func getInitalSurveys(){
    
        let surveyOne = Survey()
        let surveyTwo = Survey()
        
        surveyOne.title = "Titlo tres"
        surveyOne.descriptionText = "Temos evidências de uma nova praga em sua região. Responda esse questionário e nos ajude"
        surveyOne.category = "Novas"
    
        surveyTwo.title = "Mais um titulo"
        surveyTwo.descriptionText = "Temos evidências de uma nova praga em sua região. Responda esse questionário e nos ajude ajude ajude ajude ajude ajude"
        surveyTwo.category = "Velhas"
        
        self.surveys.append(surveyOne)
        self.surveys.append(surveyTwo)
    }
    
}
