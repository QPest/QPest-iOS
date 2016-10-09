//
//  QPestTermsViewController.swift
//  QPest
//
//  Created by Henrique Dutra on 08/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class QPestTermsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initiateTermsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didClickAcceptTerms(_ sender: AnyObject) {
    
        QPestIOSUtil.setUserAgreedTerms(status: true)
        let newViewController = QPestIOSUtil.viewControllerFromStoryboardWithIdentifier(name: "QPestTabBar", identifier: "")
        UIApplication.shared.keyWindow?.rootViewController = newViewController
    }

    @IBAction func didClickRefuseTerms(_ sender: AnyObject) {
    
        self.dismiss(animated: true) { 
            //
        }
    }
  
    private func initiateTermsView(){
        
        self.textView.isScrollEnabled = true
        
        if let url : NSURL = Bundle.main.url(forResource: "terms", withExtension: "txt") as NSURL?{
          
            do {
                // Read the file contents
                let readString = try String(contentsOf: url as URL)
                print(readString)
                self.textView.text = readString

            } catch let error as NSError {
                print("Failed reading from URL: \(url), Error: " + error.localizedDescription)
            }
            
        }
        self.textView.font = UIFont.systemFont(ofSize: 16)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textView.setContentOffset(CGPoint.zero, animated: false)
    }
}
