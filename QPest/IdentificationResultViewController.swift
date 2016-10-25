//
//  IdentificationResultViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import TextFieldEffects
import CoreLocation

class IdentificationResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var imageTaken: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var decisionButton: UIButton!
    @IBOutlet weak var takeOtherImageButton: UIButton!
    
    let locationManager : CLLocationManager = CLLocationManager()
    var locationCoordinate : CLLocation = CLLocation(latitude: 0, longitude: 0)

    var imageRecieved : UIImage = UIImage()
    var didIdentifyImage : Bool = Bool()
    var pragueIdentified : Prague!
    
    var tableCount : Int = 0
    
    var imageWasChosenFromLibrary : Bool = false
    var quantityTextField : MadokaTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configueView()
        self.decision()
        self.setupTableView()

        self.setupKeyboardSettings()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickContinue(_ sender: AnyObject) {
        self.decideForLogCreation()
    }
    
    @IBAction func didClickTakeOtherImage(_ sender: AnyObject) {
        self.decideForLogCreation()

    }
    @IBAction func didClickExit(_ sender: AnyObject) {
        self.decideForLogCreation()
    }
  
    @IBAction func didClickDecision(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "goDecision", sender: nil)
    }
    
    func decideForLogCreation(){
        if self.didIdentifyImage {
            self.createNewLog()
        }
    }
    
    func configueView(){
        self.imageTaken.image = self.imageRecieved
        self.configueButtons()
    }
    
    func configueButtons(){
    
        self.continueButton.layer.cornerRadius = 10
        self.decisionButton.layer.cornerRadius = 10
        self.takeOtherImageButton.layer.cornerRadius = 10
        
        self.continueButton.layer.borderWidth = 1
        self.decisionButton.layer.borderWidth = 1
        self.takeOtherImageButton.layer.borderWidth = 1
        
        self.continueButton.layer.borderWidth = 1
        self.decisionButton.layer.borderWidth = 1
        self.takeOtherImageButton.layer.borderWidth = 1
        
        self.continueButton.layer.borderColor = UIColor.white.cgColor
        self.decisionButton.layer.borderColor = UIColor.white.cgColor
        self.takeOtherImageButton.layer.borderColor = UIColor.white.cgColor
        
        self.continueButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.decisionButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.takeOtherImageButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    func setupKeyboardSettings(){
    
        self.hideKeyboardWhenTappedAround()

        NotificationCenter.default.addObserver(self, selector: #selector(IdentificationResultViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IdentificationResultViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func createNewLog(){
    
        let newMonitoringLog = MonitoringLog()
        newMonitoringLog.date = Date()
        newMonitoringLog.imageTaken = self.imageRecieved
        newMonitoringLog.localization = self.getLocation()
        
        if let num = Int(self.quantityTextField.text!) {
            newMonitoringLog.pragueQuantity = num
        }
        else{
            newMonitoringLog.pragueQuantity = 0
        }
        
        newMonitoringLog.prague.name = self.getPragueName()
        newMonitoringLog.setFormattedDate()
        
        MonitoringLogDataSource.defaultLogDataSource.addLog(log: newMonitoringLog)
        
        _ = SweetAlert().showAlert("Sucesso!", subTitle: "Monitoramento salvo", style: AlertStyle.success)
        
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("didSaveNewLog"), object: nil)

    }
    
    func getLocalization() -> CLLocation{
        return self.locationCoordinate
    }
    
    private func setuplocation(){
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let newCoordinate = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        self.locationCoordinate = newCoordinate
        
    }
    
    func getLocation() -> CLLocation{
        return self.locationCoordinate
    }
    

    func decision(){

        if self.didIdentifyImage{
            self.tableCount = 3
        }
        else{
            self.tableCount = 1
            self.view.backgroundColor = UIColor.colorWithHexString(hex: "A93C3C")
            self.decisionButton.isHidden = true
        }
        
        if imageWasChosenFromLibrary {
            self.takeOtherImageButton.isHidden = true
        }
    }
    
    func getPragueName() -> String{
        return "Euschistus"
    }
    
    // MARK: Table View
    
    func setupTableView(){
        
        //Registrar celulas
        self.tableView.register(UINib(nibName: "ResultsInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ResultsInfoTableViewCell.reuseIdentifier)
        
        self.tableView.register(UINib(nibName: "ResultsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: ResultsHeaderTableViewCell.reuseIdentifier)
        
        self.tableView.register(UINib(nibName: "ResultsQuantityTableViewCell", bundle: nil), forCellReuseIdentifier: ResultsQuantityTableViewCell.reuseIdentifier)
        
        //TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        
        if self.didIdentifyImage == false{
            self.tableView.isScrollEnabled = false
        }
        
    }
    
    //MARK: UITableViewDelegate
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0{
            return self.generateCellForHeader(tableview: tableView, index: indexPath as NSIndexPath)
        }
        else  if indexPath.row == 2{
            return self.generateCellForQuantity(tableview: tableView, index: indexPath as NSIndexPath)
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
        let cell = tableview.dequeueReusableCell(withIdentifier: ResultsHeaderTableViewCell.reuseIdentifier, for: index as IndexPath) as! ResultsHeaderTableViewCell
        
        cell.selectionStyle = .none
   
        if self.didIdentifyImage{
        
            cell.backgroundColor = UIColor.colorWithHexString(hex: "3CA95C")
            cell.title.text = "Identificado com sucesso"
            cell.info.text = "Veja abaixo as informações"
            cell.imageResult.image = UIImage(named: "sucess")
        }
        else{

            cell.backgroundColor = UIColor.colorWithHexString(hex: "A93C3C")
            cell.title.text = "Não identificado"
            cell.info.text = "Tente novamente"
            cell.imageResult.image = UIImage(named: "unsucess")

        }
        
        return cell
    }
    
    func generateCellForInfo(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: ResultsInfoTableViewCell.reuseIdentifier, for: index as IndexPath) as! ResultsInfoTableViewCell
        
        cell.backgroundColor = UIColor.colorWithHexString(hex: "4DCB72")
        cell.selectionStyle = .none
        
        cell.label.text = "Nome da praga : Euschistus "
        cell.label.textColor = UIColor.white
        
        return cell
    }

    
    func generateCellForQuantity(tableview : UITableView, index : NSIndexPath)->UITableViewCell{
        let cell = tableview.dequeueReusableCell(withIdentifier: ResultsQuantityTableViewCell.reuseIdentifier, for: index as IndexPath) as! ResultsQuantityTableViewCell
        
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        
        self.quantityTextField = cell.quantityTextField
        
        return cell
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    // MARK: Keyboard
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

}
