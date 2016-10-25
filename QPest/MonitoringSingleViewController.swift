//
//  MonitoringSingleViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 18/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MonitoringSingleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var logImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentLog : MonitoringLog = MonitoringLog()
    
    var mapButton : UIBarButtonItem = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView(){
    
        if let newImage = self.currentLog.imageTaken{
            self.logImage.image = newImage
            self.logImage.contentMode = .scaleAspectFill

        }
        else{
            self.logImage.image = UIImage(named: "semImagem")
            self.logImage.contentMode = .scaleAspectFill
        }
        
        if self.currentLog.localization != nil{
            self.setupMapButton()
        }
    }
    
    private func setupMapButton(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32)
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(MonitoringSingleViewController.didClickMap), for: .touchUpInside)
        button.setImage(UIImage(named: "mapIcon2"), for: .normal)
        self.mapButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = self.mapButton
        
    }
    
    func didClickMap(){
        self.performSegue(withIdentifier: "goMapView", sender: nil)
    }

    // MARK : Table view
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "ResultsInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ResultsInfoTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: "MonitoringSingleTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringSingleTableViewCell.reuseIdentifier)
        
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
            return self.generateCellForInfo(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else{
            return self.generateCellForSingleCell(tableview: tableView, index: indexPath as NSIndexPath)
        }
    
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func generateCellForSingleCell(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringSingleTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringSingleTableViewCell
        
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none

        let newDate = self.currentLog.date
        let dateFormatted : String = String(newDate.day) + " de " + QPestIOSUtil.getMonthName(month: newDate.month) + " as " + self.currentLog.dateFormatted

        switch index.row {
        case 1:
            cell.titleLabel.text = "QUANTIDADE"
            cell.resultsLabel.text = String(self.currentLog.pragueQuantity)
        case 2:
            cell.titleLabel.text = "DATA"
            cell.resultsLabel.text = dateFormatted
        default:
            break
        }
        
        return cell
    }
    
    
    func generateCellForInfo(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: ResultsInfoTableViewCell.reuseIdentifier, for: index as IndexPath) as! ResultsInfoTableViewCell
        
        cell.backgroundColor = UIColor.colorWithHexString(hex: "4DCB72")
        cell.selectionStyle = .none
        
        cell.label.text = self.currentLog.prague.name
        cell.label.textColor = UIColor.white
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goMapView"){
            let destination = segue.destination as! MonitoringMapViewController
            destination.mapLocalization = self.currentLog.localization
        }
    }


 
}
