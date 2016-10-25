//
//  MonitoringMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 07/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import SwiftDate

class MonitoringMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let monitoringTitle = "Monitoramento"
    
    var notificationIcon : String = String()
    var addIcon : String = String()
    
    var notificationButton : UIBarButtonItem = UIBarButtonItem()
    var addButton : UIBarButtonItem = UIBarButtonItem()
    
    var monitoringIndexController : Int = 0
    
    var logSelected : MonitoringLog = MonitoringLog()
    
    var tableViewOrder : [(String, MonitoringLog)] = []
    var monitoringLogs : [MonitoringLog] = []
    var monitoringDates : [Date] = []
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.getLogs()
        self.setupTableOrder()
        self.setupTableView()
        self.setupNotifications()
        
        // callback to show message that new log was saved
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(didSaveNewLog), name: Notification.Name("didSaveNewLog"), object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationBar(){
        self.navigationItem.title = self.monitoringTitle
    }
    
    private func setupNotifications(){
    
        self.notificationIcon = "notificationOn"
        self.addIcon = "addIcon"
        
        self.setupNotificationButton()
        self.setupAddIcon()
    }
    
    private func setupNotificationButton(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MonitoringMainViewController.didClickNotification), for: .touchUpInside)
        button.setImage(UIImage(named: self.notificationIcon), for: .normal)
        self.notificationButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = self.notificationButton
        
    }
    
    func didClickNotification(){
        self.performSegue(withIdentifier: "goNotificationView", sender: nil)
    }
    
    private func setupAddIcon(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MonitoringMainViewController.didClickAdd), for: .touchUpInside)
        button.setImage(UIImage(named: self.addIcon), for: .normal)
        self.addButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = self.addButton
        
    }
    
    func didClickAdd(){
        self.performSegue(withIdentifier: "goAdd", sender: nil)
    }

    func didSaveNewLog(){
         _ = SweetAlert().showAlert("Sucesso!", subTitle: "Monitoramento salvo", style: AlertStyle.success)
        
        self.reloadData()
    }
    
    func reloadData(){
    
        self.getLogs()
        self.setupTableOrder()
        self.tableView.reloadData()

    }
    
    func getLogs(){
        
        self.monitoringLogs =  MonitoringLogDataSource.defaultLogDataSource.getLogInfo()
        self.monitoringDates = MonitoringLogDataSource.defaultLogDataSource.getLogDates()
    }
    
    func setupTableOrder(){
        
        self.tableViewOrder = []
        
        for newDate in self.monitoringDates{
            
            let newMonitoringLog : MonitoringLog = MonitoringLog()
            newMonitoringLog.date = newDate
            self.tableViewOrder.append(("Date", newMonitoringLog))
            
            for newLog in self.monitoringLogs {
            
                if newLog.date.day == newDate.day{
                    self.tableViewOrder.append(("Log", newLog))
                }
               
            }
        }
        
        if self.tableViewOrder.count == 0{
            self.tableViewOrder.append(("Empty", MonitoringLog()))
        }
    }
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "MonitoringInfoTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringInfoTableViewCell.reuseIdentifier)

        self.tableView.register(UINib(nibName: "MonitoringHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier)

        self.tableView.register(UINib(nibName: "MonitoringEmptyTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringEmptyTableViewCell.reuseIdentifier)
        
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
            return self.tableViewOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if self.tableViewOrder[indexPath.row].0 == "Date"{
            return self.generateCellForHeader(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else if self.tableViewOrder[indexPath.row].0 == "Empty"{
            return self.generateCellForEmpty(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else{
            return self.generateCellForIdentification(tableview: tableView, index: indexPath as NSIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.tableViewOrder[indexPath.row].0 == "Log"{
            self.logSelected = self.tableViewOrder[indexPath.row].1
            self.performSegue(withIdentifier: "goSingle", sender: nil)
        }
    }
    
    func generateCellForHeader(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringHeaderTableViewCell
        
        cell.selectionStyle = .none
        
        let newLog =  self.tableViewOrder[index.row].1
        let newDate = newLog.date
        
        cell.dateTitle.text = String(newDate.day) + " de " + QPestIOSUtil.getMonthName(month: newDate.month)
        
        return cell
    }
    
    func generateCellForEmpty(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringEmptyTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringEmptyTableViewCell
        
        cell.selectionStyle = .none
        
        cell.titleLabel.text = "Sem monitoramentos salvos"
        
        return cell
    }
    
    func generateCellForIdentification(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringInfoTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringInfoTableViewCell
        
        cell.selectionStyle = .none
        
        let newLog = self.tableViewOrder[index.row].1
        
        cell.monitoringTime.text = newLog.dateFormatted
        cell.monitoringTitle.text = newLog.prague.name
        cell.monitoringCount.text = String(newLog.pragueQuantity)
        
        if newLog.isNaturalEnemy{
            cell.tagView.backgroundColor = ColorPalette.defaultPalette.naturalEnemyTableViewColor
        }
        else{
            cell.tagView.backgroundColor = ColorPalette.defaultPalette.pragueTableViewColor
        }

        cell.mapIcon.image = cell.mapIcon.image!.withRenderingMode(.alwaysTemplate)
        cell.mapIcon.tintColor = UIColor.lightGray
        
        if newLog.localization == nil{
            cell.mapIcon.isHidden = true
        }
        else{
            cell.mapIcon.isHidden = false
        }
        
        return cell
    }

    // Preparing for next view controller

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goSingle"){
            let destination = segue.destination as! MonitoringSingleViewController
            destination.currentLog = self.logSelected
        }
    }

}

