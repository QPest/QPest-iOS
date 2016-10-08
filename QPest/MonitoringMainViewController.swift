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
    
    var notificationButton : UIBarButtonItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.setupTableView()
        self.setupNotifications()
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
        
        self.setupNotificationButton()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0{
            return self.generateCellForHeader(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else{
            return self.generateCellForIdentidifcation(tableview: tableView, index: indexPath as NSIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Ao selecionar a tabela
    }
    
    func generateCellForHeader(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringHeaderTableViewCell
        
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func generateCellForIdentidifcation(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringInfoTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringInfoTableViewCell
        
        cell.selectionStyle = .none
        
        
        return cell
    }


}
