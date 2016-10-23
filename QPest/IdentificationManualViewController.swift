//
//  IdentificationManualViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 09/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class IdentificationManualViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var titles : [String] = ["Tire foto do percevejo visto","Caso a fato tenha ficado de boa qualidade, escolha identificar","Veja se o aplicativo conseguiu identificar o inseto","Caso tenha sido identificado, veja os resultados e tome ações de acordo"]
    
    override func viewDidLoad(){
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.colorWithHexString(hex: "3CA95C")

        self.setupNavigationBar()
        self.setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationBar(){
    
        self.navigationItem.title = "Manual de Identificação"
        
    }
    
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "IdentificationManulTableViewCell", bundle: nil), forCellReuseIdentifier: IdentificationManulTableViewCell.reuseIdentifier)
        
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func generateCell(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: IdentificationManulTableViewCell.reuseIdentifier, for: index as IndexPath) as! IdentificationManulTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.colorWithHexString(hex: "3CA95C")
        
        let newTitle = self.titles[index.row]
        
        cell.stepDescription.text = newTitle
        cell.stepNumber.image = UIImage(named: "step" + String(index.row + 1))
        
        return cell
    }

}
