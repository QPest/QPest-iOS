//
//  NotificationDataSource.swift
//  QPest
//
//  Created by Henrique Dutra on 24/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class NotificationDataSource: NSObject {

    static let defaultNotificationDataSource = NotificationDataSource()

    var controls : [QPestNotification] = []
    var news : [QPestNotification] = []

    override init(){
        
        super.init()
        
        self.addInitialNotifications()
        
    }
    
    func addInitialNotifications(){

//        let newNotification : QPestNotification = QPestNotification()
//        newNotification.notificationTitle = "Titulo"
//        newNotification.notificationDescription = "Lorem opsum"
//        newNotification.type = "Control"
//        
//        self.controls.append(newNotification)
    }
    
    func getNews() -> [QPestNotification]{
        return self.news
    }
    
    func getControls() -> [QPestNotification]{
        return self.controls
    }
}

