//
//  ActionMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ActionMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var pragues : [Prague] = []
    var backgroundColorPassed : UIColor = UIColor()
    var selectedPrague : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = backgroundColorPassed
    
        self.getPragues()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getPragues(){
        self.pragues = PragueDataSource.defaultLogDataSource.getPragues()
    }
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "ActionPragueHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: ActionPragueHeaderTableViewCell.reuseIdentifier)
        
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        self.tableView.isScrollEnabled = true
        
    }
    
    //MARK: UITableViewDelegate
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pragues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.generateCell(tableview: tableView, index: indexPath as NSIndexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        self.selectedPrague = indexPath.row
        self.performSegue(withIdentifier: "goSinglePrague", sender: nil)
        
    }

    func generateCell(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: ActionPragueHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! ActionPragueHeaderTableViewCell

        let newPrague = self.pragues[index.row]
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.pragueTitle.textColor = UIColor.white
        
        cell.pragueTitle.text = newPrague.name
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goSinglePrague"){
            let destination = segue.destination as! ActionSinglePragueViewController
            destination.pragueSelcted = self.pragues[self.selectedPrague]
        }
        
    }
    

}
