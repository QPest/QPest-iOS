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
        
        surveyOne.title = "Questionário inicial"
        surveyOne.descriptionText = "Nos ajuse a saber um pouco mais sobre você e seus terrenos"
        surveyOne.category = "Inicial"
    
        surveyTwo.title = "Nova praga"
        surveyTwo.descriptionText = "Temos evidências de uma nova praga em sua região. Responda esse questionário e nos ajude"
        surveyTwo.category = "Manejo de Pragas"
        
        self.surveys.append(surveyOne)
        self.surveys.append(surveyTwo)
    }
    
}
