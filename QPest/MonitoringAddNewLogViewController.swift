//
//  MonitoringAddLogViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 18/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import TextFieldEffects

class MonitoringAddNewLogViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var quantityTextField: HoshiTextField!
    @IBOutlet weak var pragueTextField: HoshiTextField!
    
    var quantity : Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        self.quantityTextField.delegate = self
        self.pragueTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickConfirmation(_ sender: AnyObject) {
        self.checkFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func checkFields(){

        var verification : Bool = false
        
        // Validating if the fiels are formatted
        if let _ = Int(self.quantityTextField.text!) {
            if (self.pragueTextField.text != ""){
                verification = true
            }
        }
        
        self.fieldAction(value: verification)

    }
    
    private func fieldAction(value : Bool){
    
        if value {
            self.createNewLog()

            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("didSaveNewLog"), object: nil)
        }
        else{
            self.putMessage()
        }
    }
    
    private func putMessage(){

        _ = SweetAlert().showAlert("Erro!", subTitle: "1 ou mais campos com erro", style: AlertStyle.none)
        
    }

    private func createNewLog(){
    
        let newLog = MonitoringLog()

        newLog.date = Date()
        newLog.prague.name = self.pragueTextField.text!
        newLog.pragueQuantity = self.quantity
        
        MonitoringLogDataSource.defaultLogDataSource.addLog(log: newLog)
        
        self.dismissView()
    }
    
    func dismissView(){
       _ = self.navigationController?.popViewController(animated: true)
    }
    
}
