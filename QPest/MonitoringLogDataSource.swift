//
//  MonitoringLogDataSource.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//
// Data source to explor moniroting logs

import UIKit
import SwiftDate

class MonitoringLogDataSource: NSObject {

    static let defaultLogDataSource = MonitoringLogDataSource()

    var monitoringLogs : [MonitoringLog] = []
    var monitoringDates : [Date] = []
    
    override init(){

        super.init()
        
        self.addInitialLogs()

    }
    
    func saveData(){
    
    }
    
    func addLog(log : MonitoringLog){
        self.monitoringLogs.append(log)
        self.compareDates(log: log)
        self.sortLogs()
        self.saveData()
    }
    
    func deleteLog(index : Int){
        
    }
    
    func sortLogs(){
    
        self.monitoringLogs.sort { $0.date > $1.date }
        self.monitoringDates.sort { $0 > $1 }

    }
    
    func compareDates(log : MonitoringLog){
    
        let pos = 0
        
        if log.date.day != self.monitoringDates[pos].day || log.date.month != self.monitoringDates[pos].month {
            self.monitoringDates.append(log.date)
        }
    }
    
    func addInitialLogs(){
    
        let logOne = MonitoringLog()
        let logTwo = MonitoringLog()
        let logThree = MonitoringLog()
        let logFour = MonitoringLog()
    
        logOne.isPrague = true
        logOne.pragueQuantity = 6
        logOne.prague.name = "Euschistus"
        logOne.date = Date() - 2.day
        
        logTwo.isPrague = true
        logTwo.pragueQuantity = 13
        logTwo.prague.name = "Euschistus"
        logTwo.date = Date() - 2.day

        logThree.isNaturalEnemy = true
        logThree.pragueQuantity = 1
        logThree.prague.name = "Zellus"
        logThree.date = Date() - 1.day

        logFour.isPrague = true
        logFour.pragueQuantity = 2
        logFour.prague.name = "Euschistus"
        logFour.date = Date() - 2.day


        logOne.setFormattedDate()
        logTwo.setFormattedDate()
        logThree.setFormattedDate()
        logFour.setFormattedDate()
        
        self.monitoringLogs.append(logOne)
        self.monitoringLogs.append(logTwo)
        self.monitoringLogs.append(logThree)
        self.monitoringLogs.append(logFour)
        
        self.sortLogs()
        
        self.monitoringDates.append(Date() - 1.day)
        self.monitoringDates.append(Date() - 2.day)

    }
    
    func getLogInfo() -> [MonitoringLog]{
        return self.monitoringLogs
    }
    
    func getLogDates() -> [Date]{
        return self.monitoringDates
    }
    
}
