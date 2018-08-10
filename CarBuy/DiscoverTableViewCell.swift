//
//  DiscoverTableViewCell.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
    
    
    // Instance variables
    
    @IBOutlet var carImage: UIImageView!
    
    @IBOutlet var carName: UILabel!
    
    @IBOutlet var carStyle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

