//
//  CameraViewController.swift
//  QPest
//
//  Created by Danilo Mendes on 10/9/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit
import CameraManager

class CameraViewController: UIViewController {

    // MARK: - Constant
    
    @IBOutlet weak var cameraView: UIView!
    let cameraManager = CameraManager()
    
    // MARK: - Outlets
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cameraManager.showAccessPermissionPopupAutomatically = true
        
        let currentCameraState = cameraManager.currentCameraStatus()
        
        if currentCameraState == .ready {
            self.addCameraToView()
        }
        
        if cameraManager.hasFlash {
            flashButton.isHidden = false;
            cameraManager.flashMode = .auto
            flashButton.titleLabel?.text = "Flash: Auto"
        }else{
            flashButton.isHidden = true;
        }
        
        cameraManager.writeFilesToPhoneLibrary = false
    }
    
    fileprivate func addCameraToView(){
        _ = cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.stillImage)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alertAction) -> Void in  }))
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        cameraManager.resumeCaptureSession()
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        if (cameraManager.cameraOutputMode) == .stillImage {
            
            cameraManager.capturePictureWithCompletion({ (imageCaptured, error) -> Void in
                if let errorOccured = error {
                    self.cameraManager.showErrorBlock("Error occurred", errorOccured.localizedDescription)
                }
                else {
                    
                    self.image = imageCaptured
                    self.performSegue(withIdentifier: "goImage", sender: nil);
                    
                    /*
                    let vc: ImageViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageViewController
                    if let validVC: ImageViewController = vc {
                        if let capturedImage = imageCaptured {
                            validVC.image = capturedImage
                            self.navigationController?.pushViewController(validVC, animated: true)
                        }
                    }
                    */
                }
            })
        }
    }
    @IBAction func changeFlashValue(_ sender: UIButton) {
        
        let flashMode = cameraManager.changeFlashMode()
        
        switch flashMode {
        case .auto:
            flashButton.setTitle("Flash: Auto", for: .normal)
            break
        case .off:
            flashButton.setTitle("Flash: Off", for: .normal)
            break
        case .on:
            flashButton.setTitle("Flash: On", for: .normal)
        }
        
    }
    
    @IBAction func leaveCamera(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.stopCaptureSession()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goImage" {
            let imageViewController = segue.destination as! ImageViewController
            imageViewController.image = self.image
        }
    }
    

}
