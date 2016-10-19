//
//  GeneralInfoMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class GeneralInfoMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var backgroundColorPassed : UIColor = UIColor()

    var titles : [String] = ["Gráfico Curvado", "Gráfico de Barra", "Gráfico de Pontos", "Exportar dados"]
    var images : [String] = ["graphCurve", "graphBar","graphDot","export"]

    var selectedGraph : Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColorPassed
        
        self.setupTableView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "IdentificationMainTableViewCell", bundle: nil), forCellReuseIdentifier: IdentificationMainTableViewCell.reuseIdentifier)
        
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
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.generateCell(tableview: tableView, index: indexPath as NSIndexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        if indexPath.row < 3{
            self.selectedGraph = indexPath.row
            self.performSegue(withIdentifier: "goGraph", sender: nil)
        }
        else {
            self.exportData()
        }
    }
    
    func generateCell(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: IdentificationMainTableViewCell.reuseIdentifier, for: index as IndexPath) as! IdentificationMainTableViewCell
        
        cell.backgroundColor = UIColor.clear

        cell.selectionStyle = .none
        
        let newTitle = self.titles[index.row]
        let newImage = self.images[index.row]
        
        cell.labelTitle.text = newTitle
        cell.labelTitle.textColor = UIColor.white
        
        cell.imageIcon.image = UIImage(named: newImage)
        
        return cell
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goGraph"){
            let destination = segue.destination as! GraphViewController
            destination.graphType = self.selectedGraph
        }
   
    }
    
    func exportData(){
    
        
    }
    
}
