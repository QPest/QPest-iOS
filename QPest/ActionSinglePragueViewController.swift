//
//  ActionSinglePragueViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ActionSinglePragueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pragueTitle: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var pragueSelcted : Prague = Prague()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickExit(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    func configureView(){
    
        self.pragueTitle.text = pragueSelcted.name
        self.exitButton.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(M_PI)) / 180.0)

    }
    
    
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "MonitoringHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: "ActionInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ActionInfoTableViewCell.reuseIdentifier)
        
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0{
            return self.generateCellForHeader(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else{
            return self.generateCellForInfo(tableview: tableView, index: indexPath as NSIndexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func generateCellForHeader(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: MonitoringHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! MonitoringHeaderTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
    
        switch index.row {
        case 0:
            cell.cellTitle.text = "Descrição"
        case 2:
            cell.cellTitle.text = "Bioecologia"
        case 4:
            cell.cellTitle.text = "Danos"
        default:
            break
        }
        
        return cell
    }
    
    func generateCellForInfo(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: ActionInfoTableViewCell.reuseIdentifier, for: index as IndexPath) as! ActionInfoTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        
        switch index.row {
        case 1:
            cell.cellText.text = self.pragueSelcted.descriptionText
        case 3:
            cell.cellText.text = self.pragueSelcted.bioecology
        case 5:
            cell.cellText.text = self.pragueSelcted.damage
        default:
            break
        }
        
        return cell
    }
    
}

