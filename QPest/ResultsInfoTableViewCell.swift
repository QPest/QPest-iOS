//
//  ResultsInfoTableViewCell.swift
//  QPest
//
//  Created by Henrique Dutra on 21/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ResultsInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    class var reuseIdentifier: String {
        get {
            return "resultsInfo"
        }
    }
}
