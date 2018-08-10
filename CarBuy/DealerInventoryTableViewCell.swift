//
//  DealerInventoryTableViewCell.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class DealerInventoryTableViewCell: UITableViewCell {
    
    
    // Instance variables from storyboard
    @IBOutlet weak var carHeadingLabel: UILabel!
    
    @IBOutlet weak var dealerLabel: UILabel!
    
    @IBOutlet weak var exteriorLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var msrpLabel: UILabel!
    
    @IBOutlet weak var carImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
