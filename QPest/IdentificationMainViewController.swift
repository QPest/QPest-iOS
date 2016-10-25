//
//  IdentificationMainViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 07/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class IdentificationMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let identificationTitle = "Identificação"
    var searchButton : UIBarButtonItem = UIBarButtonItem()
    
    var pickedImage : UIImage = UIImage()
    
    @IBOutlet weak var tableView: UITableView!
    
    // Table view data
    var titles : [String] = ["Tirar foto", "Escolher da biblioteca","Ações","Manual de Identificação"]
    var images : [String] = ["camera", "photo-library","identificationMenu","manual"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationBar(){
        self.navigationItem.title = self.identificationTitle
    }
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
        
    }
    
    func didCSelectCameraLibrary(){
    
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
     
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.pickedImage = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
        self.didGetImage()
    }
    
    func didGetImage(){
    
        self.performSegue(withIdentifier: "goImageViewController", sender: nil)
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
        
        if indexPath.row == 0{
            self.performSegue(withIdentifier: "goCamera", sender: nil)

        }
        else  if indexPath.row == 1{
            // Camera library selected
            self.didCSelectCameraLibrary()
        }
        else  if indexPath.row == 2{
            self.performSegue(withIdentifier: "goMenu", sender: nil)
        }
        else if indexPath.row == 3{
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goImageViewController"){
            let destination = segue.destination as! ImageViewController
            destination.image = self.pickedImage
            destination.imageWasChosenFromLibrary = true
        }
        
    }
    
}
