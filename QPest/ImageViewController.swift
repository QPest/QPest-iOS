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
        let cascadePath = Bundle.main.path(forResource: "Euschistus_cascade_stage8", ofType: "xml")
        
        // Set size to scale down the image taken and save process time
        let scale = 200 / (imageView.image?.size.width)!
        let size = CGSize(width: 200, height: (imageView.image?.size.height)! * scale)
        let imageCropped = OpenCVWrapper.resize(imageView.image, newSize: size)
        
        let imageDetect = OpenCVWrapper.detectCascade(imageCropped, withCascade: cascadePath)
        //self.imageView.image = imageCropped
        self.imageView.image = imageDetect
        
        // Try to detect object in image
        let objectDetected = OpenCVWrapper.cascadeDetected(imageCropped, withCascade: cascadePath)
        
        if objectDetected {
            print("Detected")
            self.imageWasDetected = true
            self.createPragueWithName(name: "Euschistus")
        }else{
            print("Not detected")
            self.imageWasDetected = false
        }
        
        self.goToResults()
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
        }
        
    }
        
}
