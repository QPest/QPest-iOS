//
//  MonitoringLogDataSource.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//
// Data source to explor moniroting logs

import UIKit

class MonitoringLogDataSource: NSObject {

    static let defaultLogDataSource = MonitoringLogDataSource()

    var monitoringLogs : [MonitoringLog] = []
    var monitoringDates : [Date] = []
    
    override init(){

        super.init()
        
        self.addInitialLogs()

    }
    
    func addLog(log : MonitoringLog){
        self.monitoringLogs.append(log)
    }
    
    func deleteLog(index : Int){
        
    }
    
    func reload(){
    
    }
    
    func addInitialLogs(){
    
        let logOne = MonitoringLog()
        let logTwo = MonitoringLog()
        let logThree = MonitoringLog()
        let logFour = MonitoringLog()
    
        logOne.isPrague = true
        logOne.pragueQuantity = 6
        logOne.prague.name = "Euschistus"
        logOne.date = Date()
        
        logTwo.isPrague = true
        logTwo.pragueQuantity = 13
        logTwo.prague.name = "Euschistus"
        logTwo.date = Date()

        logThree.isNaturalEnemy = true
        logThree.pragueQuantity = 1
        logThree.prague.name = "Inimigo Natural"
        logThree.date = Date()

        logFour.isPrague = true
        logFour.pragueQuantity = 2
        logFour.prague.name = "Euschistus"
        logFour.date = Date()

        logOne.dateFormatted = "16:32"
        logTwo.dateFormatted = "16:32"
        logThree.dateFormatted = "16:32"
        logFour.dateFormatted = "16:32"
        
        self.monitoringLogs.append(logOne)
        self.monitoringLogs.append(logTwo)
        self.monitoringLogs.append(logThree)
        self.monitoringLogs.append(logFour)
        
        self.monitoringDates.append(Date())
    }
    
    func getLogInfo() -> [MonitoringLog]{
        return self.monitoringLogs
    }
    
    func getLogDates() -> [Date]{
        return self.monitoringDates
    }
    
}
