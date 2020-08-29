//
//  FoodItem.swift
//  UT Menu
//
//  Created by Aditya Kuppa on 3/18/20.
//  Copyright © 2020 Aditya Kuppa. All rights reserved.
//

import Foundation
import SwiftSoup
import UIKit

class FoodItem {
    
    var name = ""
    var properties = [UIImage]()
    
    init(name: String, properties: [String]) {
        self.name = name
        self.properties = findImages(properties : properties)
    }
    
    init() {
        
    }
    
    func findImages(properties: [String]) -> [UIImage] {
        //var array = [UIImage?]()
//        for property in properties {
//            let name = updateImgName(name: property)
//            let img = UIImage(named: "\(name).png")
//            array.append(img)
//        }
        return []
        //return array
    }
    
    func updateImgName(name: String) -> String {
        var string = ""
        if let index = name.firstIndex(of: ".") {
            let substring = name[..<index]   // ab
            string = String(substring)
        }
        return string
    }
    
    func getName() -> String {
        return name
    }
    
    func getProperties() -> [UIImage] {
        return properties
    }
    
    
    
}
