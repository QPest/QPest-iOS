//
//  ActionInfoTableViewCell.swift
//  QPest
//
//  Created by Henrique Dutra on 25/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ActionInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellText: UILabel!

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
            return "actionInfoCell"
        }
    }
}
