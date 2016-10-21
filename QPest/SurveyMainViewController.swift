//
//  SurveyViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class SurveyMainViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var surveys : [Survey] = []
    
    var backgroundColorPassed : UIColor = UIColor()
    
    var selectedSurveyIndex : Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = backgroundColorPassed
    
        self.getSurveys()
        self.setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didClickBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getSurveys(){
    
        self.surveys = SurveyDataSource.defaultSurveyDataSource.surveys
    }
    
    private func goSurvey(){
    
        self.performSegue(withIdentifier: "goSurvey", sender: nil)
    }
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "SurveyHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: SurveyHeaderTableViewCell.reuseIdentifier)
        
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = true
        
    }
    
    //MARK: UITableViewDelegate
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.generateCell(tableview: tableView, index: indexPath as NSIndexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedSurveyIndex = indexPath.row
        self.goSurvey()
    }
    
    func generateCell(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: SurveyHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! SurveyHeaderTableViewCell

        let newSurvey = self.surveys[index.row]
        
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        cell.selectionStyle = .none
        
        cell.orderNumber.text = String(index.row + 1)
        cell.category.text = "Categoria: " + newSurvey.category
        cell.quantity.text = String(newSurvey.questions.count)
        cell.title.text = newSurvey.title
        cell.descriptionText.text = newSurvey.descriptionText
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goSurvey"){
            let destination = segue.destination as! SurveyFlowViewController
            destination.survey = self.surveys[self.selectedSurveyIndex]
        }
        
    }

}
