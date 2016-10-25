//
//  MonitoringInfoTableViewCell.swift
//  QPest
//
//  Created by Henrique Dutra on 08/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class MonitoringInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var monitoringTime: UILabel!
    @IBOutlet weak var monitoringTitle: UILabel!
    @IBOutlet weak var monitoringCount: UILabel!
    @IBOutlet weak var mapIcon: UIImageView!
    
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
            return "monitoringCell"
        }
    }
}
