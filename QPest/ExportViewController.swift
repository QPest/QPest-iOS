//
//  ExportViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 23/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import MessageUI

class ExportViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var options : [String] = ["CSV", "Texto"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configurePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickExit(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickExport(_ sender: AnyObject) {
        self.exportData()
    }
    
    func configurePicker(){
    
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    func exportData(){
    
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setSubject("Monitoramento de Pragas do dia")
     
        //mailComposerVC.addAttachmentData(fileData, mimeType: "audio/wav", fileName: "swifts")

        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
       
       _ =  SweetAlert().showAlert("Erro!", subTitle: "Erro na tentativa de envio do email", style: .error)
        
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
  
    
    // MARK: Picker View configurations
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.options.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.options[row]
    }
    
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: self.options[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
        return attributedString
    }

}
