//
//  MonitoringHeaderTableViewCell.swift
//  QPest
//
//  Created by Henrique Dutra on 08/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MonitoringHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTitle: UILabel!
    
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
            return "headerCell"
        }
    }
    
}
