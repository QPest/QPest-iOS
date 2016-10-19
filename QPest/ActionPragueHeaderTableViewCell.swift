//
//  ActionPragueHeaderTableViewCell.swift
//  QPest
//
//  Created by Henrique Dutra on 19/10/16.
//  Copyright © 2016 Henrique Dutra. All rights reserved.
//

import UIKit

class ActionPragueHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var pragueTitle: UILabel!

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
            return "pragueHeader"
        }
    }
}
