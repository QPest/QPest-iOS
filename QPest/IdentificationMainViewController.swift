//
//  IdentificationMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 07/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class IdentificationMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let identificationTitle = "Identificação"
    var searchButton : UIBarButtonItem = UIBarButtonItem()

    var titles : [String] = ["Tirar foto", "Escolher da biblioteca","Manual de Identificação"]
    var images : [String] = ["camera", "photo-library", "manual"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setupNavigationBar()
        self.setupTableView()
        self.setupHelp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationBar(){
        
        self.navigationItem.title = self.identificationTitle
    }
    
    private func setupHelp(){
        
        let rect = CGRect(x: 0, y: 0, width: 32, height: 32) // CGFloat, Double, Int
        
        let button = UIButton(frame: rect)
        button.addTarget(self, action: #selector(IdentificationMainViewController.didClickHelp), for: .touchUpInside)
        button.setImage(UIImage(named: "helpIcon"), for: .normal)
        self.searchButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = self.searchButton
    }
    
    func didClickHelp(){
        
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
        return 185
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            let vc: CameraViewController? = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "CameraStoryboard", identifier: "") as? CameraViewController
            //self.navigationController?.pushViewController(vc!, animated: true)
            //self.show(vc!, sender: nil)
            self.performSegue(withIdentifier: "goCamera", sender: nil)
        }
        else  if indexPath.row == 1{
            // Camera library selected
        }
        else if indexPath.row == 2{
            self.performSegue(withIdentifier: "goManual", sender: nil)
        }
        
    }
    
    func generateCell(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: IdentificationMainTableViewCell.reuseIdentifier, for: index as IndexPath) as! IdentificationMainTableViewCell
        
        cell.selectionStyle = .none
        
        let newTitle = self.titles[index.row]
        let newImage = self.images[index.row]
        
        cell.labelTitle.text = newTitle
        cell.imageIcon.image = UIImage(named: newImage)
        
        return cell
    }
    
}
