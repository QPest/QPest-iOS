//
//  ImageViewController.swift
//  QPest
//
//  Created by Danilo Mendes on 10/9/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var image : UIImage?
    var imageWasDetected : Bool = Bool()
    var imageWasChosenFromLibrary : Bool = false
    
    var pragueIdentified : Prague!
    var isPrague : Bool = Bool()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var identifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let validImage = self.image {
            self.imageView.image = validImage
        }
        
        self.setupButtonsAppearance()

    }

    private func setupButtonsAppearance(){
        
        self.identifyButton.layer.cornerRadius = 10
        self.discardButton.layer.cornerRadius = 10
        
        self.identifyButton.layer.borderWidth = 1
        self.discardButton.layer.borderWidth = 1
        
        self.identifyButton.layer.borderColor = UIColor.white.cgColor
        self.discardButton.layer.borderColor = UIColor.white.cgColor
        
        self.identifyButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        self.discardButton.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    

    @IBAction func didClickBack(_ sender: AnyObject) {
        self.dismissView()
    }
    
    @IBAction func discardImage(_ sender: UIButton) {
        self.dismissView()
    }

    @IBAction func identifyImage(_ sender: UIButton) {
        // Path to the trained cascade for faces
        let euschistus9Path = Bundle.main.path(forResource: "Euschistus_stage9", ofType: "xml")
        let zellusPath = Bundle.main.path(forResource: "Zellus_stage16", ofType: "xml")
        
        let pathsPrague : [String:String] = [euschistus9Path! : "Euschistus"]
        let pathsEnemy : [String:String] = [zellusPath! : "Zellus"]
        
        // Set size to scale down the image taken and save process time
        let scale = 200 / (imageView.image?.size.width)!
        let size = CGSize(width: 200, height: (imageView.image?.size.height)! * scale)
        let imageCropped = OpenCVWrapper.resize(imageView.image, newSize: size)
        
        for (cascade, namePrague) in pathsPrague {
            // Try to detect object in image
            self.imageWasDetected = detectObject(cascade: cascade,
                                                 imageCropped: imageCropped!,
                                                 nameObject: namePrague)
            
            if self.imageWasDetected == true{
                self.isPrague = true
                break
            }
            
        }
        
        if self.imageWasDetected == true {
            // Continue
        } else {
        
            for (cascade, namePrague) in pathsEnemy {
                // Try to detect object in image
                self.imageWasDetected = detectObject(cascade: cascade,
                                                     imageCropped: imageCropped!,
                                                     nameObject: namePrague)
                
                if self.imageWasDetected == true{
                    self.isPrague = false
                    break
                }
            }
            
        }
        
        self.goToResults()
    }

    private func detectObject(cascade: String, imageCropped: UIImage, nameObject: String) -> Bool{
        let objectDetected = OpenCVWrapper.cascadeDetected(imageCropped, withCascade: cascade)
        
        if objectDetected {
            print("Detected")
            self.createPragueWithName(name: nameObject)
            
            let imageDetect = OpenCVWrapper.detectCascade(imageCropped, withCascade: cascade)
            self.imageView.image = imageDetect
            
        }else{
            print("Not detected")
        }
        
        return objectDetected
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func goToResults(){
        self.performSegue(withIdentifier: "goResults", sender: nil)
    }
    
    func createPragueWithName(name : String){
    
        let newPrague : Prague = Prague()
        newPrague.name = name
        
        self.pragueIdentified = newPrague
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goResults"){
            let destination = segue.destination as! IdentificationResultViewController
            destination.didIdentifyImage = self.imageWasDetected
            destination.imageRecieved = self.imageView.image!
            destination.imageWasChosenFromLibrary = self.imageWasChosenFromLibrary
            destination.pragueIdentified = self.pragueIdentified
            destination.ispragueIdentified = self.isPrague
        }
        
    }
        
}
