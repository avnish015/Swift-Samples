//
//  customTableViewCell.swift
//  TableViewSample
//
//  Created by avnish kumar on 28/06/17.
//  Copyright © 2017 avnish kumar. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var student:Student? {
        
        didSet{
            photoView.image = student?.photo
            label.text = student?.name
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
