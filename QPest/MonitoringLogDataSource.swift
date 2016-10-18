//
//  MonitoringLogDataSource.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MonitoringLogDataSource: NSObject {

    static let defaultLogDataSource = MonitoringLogDataSource()

    var monitoringLogs : [MonitoringLog] = []
    var order : [Int] = []
    
    override init(){

        super.init()
        
        self.addInitialLogs()

    }
    
    func addLog(log : MonitoringLog){
    
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
        logOne.pragueQuantity = 3
        logOne.pragueName = "Euschistus"
        
        logTwo.isPrague = true
        logTwo.pragueQuantity = 3
        logTwo.pragueName = "Euschistus"
        
        logThree.isPrague = true
        logThree.pragueQuantity = 3
        logThree.pragueName = "Euschistus"
        
        logThree.isPrague = true
        logThree.pragueQuantity = 3
        logThree.pragueName = "Euschistus"
        
        logFour.isPrague = true
        logFour.pragueQuantity = 3
        logFour.pragueName = "Euschistus"
        
        logOne.dateFormatted = "16:32"
        logTwo.dateFormatted = "16:32"
        logThree.dateFormatted = "16:32"
        logFour.dateFormatted = "16:32"
        
        self.monitoringLogs.append(logOne)
        self.monitoringLogs.append(logTwo)
        self.monitoringLogs.append(logThree)
        self.monitoringLogs.append(logFour)
    }
    
    func getLogInfo() -> [MonitoringLog]{
    
        var newInfo : [MonitoringLog] = []
        
        newInfo.append(MonitoringLog())
        newInfo.append(self.monitoringLogs[0])
        newInfo.append(self.monitoringLogs[1])
        newInfo.append(self.monitoringLogs[2])
        newInfo.append(self.monitoringLogs[3])

        
        return newInfo
    
    }
    
    func getOrder() -> [Int]{
    
        self.makeOrder()
        
        return self.order
    
    }
    
    private func makeOrder(){
    
        self.order = [1,2,2,2,2]
        
    }
}
