//
//  MonitoringNotificationViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 08/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MonitoringNotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var controls : [QPestNotification] = []
    var news : [QPestNotification] = []
    
    var tableViewOrder : [(String, QPestNotification)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getControlsAndNews()
        self.setupOrder()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getControlsAndNews(){
    
        // getControls
        self.controls = NotificationDataSource.defaultNotificationDataSource.getControls()
        
        // get news
        self.news = NotificationDataSource.defaultNotificationDataSource.getNews()

        if self.controls.count == 0{
            let newNotification : QPestNotification = QPestNotification()
            newNotification.notificationTitle = "emptyControl"
            self.controls.append(newNotification)
        }
    
        if self.news.count == 0{
            let newNotification : QPestNotification = QPestNotification()
            newNotification.notificationTitle = "emptyNews"
            self.news.append(newNotification)
        }
    }

    func setupOrder(){
    
        let newNotification : QPestNotification = QPestNotification()
        newNotification.notificationTitle = "Novidades"
        self.tableViewOrder.append(("section", newNotification))
        
        for newNews in self.news{
            self.tableViewOrder.append(("news", newNews))
        }
        
        let newNotification2 : QPestNotification = QPestNotification()
        newNotification2.notificationTitle = "Controle"
        self.tableViewOrder.append(("section", newNotification2))

        for newControl in self.controls{
            self.tableViewOrder.append(("control", newControl))
        }
        
    }
    
    // MARK : Table view
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "MonitoringHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier)
        
        self.tableView.register(UINib(nibName: "MonitoringEmptyTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringEmptyTableViewCell.reuseIdentifier)
        
        self.tableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: NotificationTableViewCell.reuseIdentifier)

        
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = true
        
    }
    
    //MARK: UITableViewDelegate
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count + self.controls.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.tableViewOrder[indexPath.row].0 == "section"{
            return self.generateCellForHeader(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else if self.tableViewOrder[indexPath.row].1.notificationTitle == "emptyNews"{
            return self.generateCellForEmpty(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else if self.tableViewOrder[indexPath.row].1.notificationTitle == "emptyControl"{
            return self.generateCellForEmpty(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else{
            return self.generateCellForNotification(tableview: tableView, index: indexPath as NSIndexPath)
        }
       
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func generateCellForHeader(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringHeaderTableViewCell
        
        cell.selectionStyle = .none
        
        cell.cellTitle.text = self.tableViewOrder[index.row].1.notificationTitle
        
        return cell
    }
    
    func generateCellForNotification(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier, for: index as IndexPath) as! NotificationTableViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.colorWithHexString(hex: "3CA95C").withAlphaComponent(0.05)
        
        let newNotification : QPestNotification = self.tableViewOrder[index.row].1
        
        cell.titleLabel.text = newNotification.notificationTitle
        cell.descriptionLabel.text = newNotification.notificationDescription
        
        return cell
    }
    
    func generateCellForEmpty(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringEmptyTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringEmptyTableViewCell
        
        cell.selectionStyle = .none
        
        if self.tableViewOrder[index.row].1.notificationTitle == "emptyNews"{
            cell.titleLabel.text = "Sem novidades"
        }
        else if self.tableViewOrder[index.row].1.notificationTitle == "emptyControl"{
            cell.titleLabel.text = "Sem notificações de controle"
        }
        
        return cell
    }
    
    // Preparing for next view controller
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "goSingle"){
//            let destination = segue.destination as! MonitoringSingleViewController
//            destination.currentLog = self.logSelected
//        }
//    }
}

