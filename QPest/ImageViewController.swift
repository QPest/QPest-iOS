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
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var identifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let validImage = self.image {
            self.imageView.image = validImage
        }
        
    }
    
    @IBAction func discardImage(_ sender: UIButton) {
        print("Discard image.")
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func identifyImage(_ sender: UIButton) {
        // Path to the trained cascade for faces
        let cascadePath = Bundle.main.path(forResource: "haarcascade_frontalface_alt_tree", ofType: "xml")
        
        // Set size to scale down the image taken and save process time
        let scale = 200 / (imageView.image?.size.width)!
        let size = CGSize(width: 200, height: (imageView.image?.size.height)! * scale)
        let imageCropped = OpenCVWrapper.resize(imageView.image, newSize: size)
        
        //let imageDetect = OpenCVWrapper.detectCascade(imageCropped, withCascade: cascadePath)
        //self.imageView.image = imageCropped
        //self.imageView.image = imageDetect
        
        // Try to detect object in image
        let objectDetected = OpenCVWrapper.cascadeDetected(imageCropped, withCascade: cascadePath)
        
        if objectDetected {
            print("Detected")
        }else{
            print("Not detected")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
