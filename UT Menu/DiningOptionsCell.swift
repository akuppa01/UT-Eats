//
//  DiningOptionsCell.swift
//  UT Menu
//
//  Created by Aditya Kuppa on 3/16/20.
//  Copyright © 2020 Aditya Kuppa. All rights reserved.
//

import UIKit

class DiningOptionsCell: UITableViewCell {
     
    @IBOutlet weak var optionTitleLabel: UILabel!
    
    
    
    func setOption(option: String) {
        optionTitleLabel.text = option
    }
    
}
