//
//  PragueDataSource.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class PragueDataSource: NSObject {

    static let defaultLogDataSource = PragueDataSource()

    var initialPragues : [String] =  [" Neomegalotomus simplex"," Euschistus heros"," Thyanta perditor"," Piezodorus guild"," Dichelops fur","LeLpetopgtologslosussussps.p"]
    
    var pragues : [Prague] = []
    
    override init(){
        super.init()
        
        self.getInitialPragues()
    }
    
    func getInitialPragues(){
    
        for (index,_) in self.initialPragues.enumerated(){
        
            let newPrague = Prague()
            newPrague.name = self.initialPragues[index]
        
            self.pragues.append(newPrague)
        }
    
    }
    
    func getPragues()-> [Prague]{
        return pragues
    }

}
