//
//  CustomTableViewCell.swift
//  FirstWatchOSApp
//
//  Created by avnish kumar on 14/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var employeeIdLabel: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    
    var employee:Employee? {
        
        didSet {
            employeeIdLabel.text = employee?.id
            employeeNameLabel.text = employee?.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
