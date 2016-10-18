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
        }
        else{
            self.putMessage()
        }
    }
    
    private func putMessage(){
        
        //
    }

    private func createNewLog(){
    
        let newLog = MonitoringLog()

        newLog.date = Date()
        newLog.pragueName = self.pragueTextField.text!
        newLog.pragueQuantity = self.quantity
        
        self.dismissView()
    }
    
    func dismissView(){
    
       _ = self.navigationController?.popViewController(animated: true)

    }
    
    
}
