//
//  MonitoringMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 07/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MonitoringMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let monitoringTitle = "Monitoramento"
    
    var notificationIcon : String = String()
    var addIcon : String = String()
    
    var notificationButton : UIBarButtonItem = UIBarButtonItem()
    var addButton : UIBarButtonItem = UIBarButtonItem()
    
    var tableViewOrder : [Int] = []
    var tableViewInfo : [MonitoringLog] = []
    
    var monitoringIndexController : Int = 0
    
    var logSelected : MonitoringLog = MonitoringLog()
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.getLogs()
        self.setupTableView()
        self.setupNotifications()
        
        // callback to show message that new log was saved
        //NotificationCenter.default.addObserver(self, selector: #selector(MonitoringMainViewController.didSaveNewLog), name: "didSaveNewLog", object: nil)
       
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
    }
    
    func getLogs(){
    
        MonitoringLogDataSource.defaultLogDataSource.reload()
        self.tableViewOrder = MonitoringLogDataSource.defaultLogDataSource.getOrder()
        self.tableViewInfo = MonitoringLogDataSource.defaultLogDataSource.getLogInfo()
        
    }
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "MonitoringInfoTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringInfoTableViewCell.reuseIdentifier)

        self.tableView.register(UINib(nibName: "MonitoringHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier)
        
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

        if self.tableViewOrder[indexPath.row] == 1{
            return self.generateCellForHeader(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else{
            return self.generateCellForIdentidifcation(tableview: tableView, index: indexPath as NSIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if self.tableViewOrder[indexPath.row] == 1{
            return 120
        }
        else{
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.logSelected = self.tableViewInfo[indexPath.row]
        self.performSegue(withIdentifier: "goSingle", sender: nil)
    }
    
    func generateCellForHeader(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringHeaderTableViewCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func generateCellForIdentidifcation(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringInfoTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringInfoTableViewCell
        
        cell.selectionStyle = .none
        
        let newLog = self.tableViewInfo[index.row]
        
        cell.monitoringTime.text = newLog.dateFormatted
        cell.monitoringTitle.text = newLog.prague.name
        cell.monitoringCount.text = String(newLog.pragueQuantity)
        
        if newLog.isNaturalEnemy{
        
            cell.tagView.backgroundColor = ColorPalette.defaultPalette.naturalEnemyTableViewColor
        }
        else{
        
            cell.tagView.backgroundColor = ColorPalette.defaultPalette.pragueTableViewColor

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

