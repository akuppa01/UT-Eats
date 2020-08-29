//
//  FoodItemCell.swift
//  UT Menu
//
//  Created by Aditya Kuppa on 3/18/20.
//  Copyright © 2020 Aditya Kuppa. All rights reserved.
//

import UIKit

class FoodItemCell: UITableViewCell {
    
    @IBOutlet weak var itemStack: UIStackView!
    @IBOutlet weak var itemName: UILabel!
    
    func setItem(item: FoodItem) {
        let text = item.getName()
        itemName.text = text
        itemName.font = UIFont.systemFont(ofSize: 16.0)
        if text.contains("-- ") {
            itemName.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        let images = item.getProperties()
        for image in images {
            let imageView = UIImageView(image: image)
            itemStack.addArrangedSubview(imageView)
        }
    }
    
    func setNoOptions() {
        itemName.text = "Restaurant Closed At This Time!"
    }
    
    

}
