//
//  DetailViewController.swift
//  UT Menu
//
//  Created by Aditya Kuppa on 3/17/20.
//  Copyright © 2020 Aditya Kuppa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var optionTitle: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    
    var mealIndex = 0
    var meals = [[FoodItem]]()
    var foodOptions = [FoodItem]()
    var ttl = ""
    var link = ""
    var index = 0
    
    func setText(ttl: String, link: String, index: Int) {
        self.ttl = ttl
        self.link = link
        self.index = index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionTitle.text = ttl
        meals = DiningOptions().getMeals(index: self.index)
        myTableView.dataSource = self
        myTableView.delegate = self
     
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
         case 0:
            mealIndex = 0
         case 1:
            mealIndex = 1
         case 2:
            mealIndex = 2
         default:
             break
         }
        self.myTableView.reloadData();
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 1
        print("---> \(mealIndex) \(meals.count)")
        if meals.count != 0 && mealIndex < meals.count{
            foodOptions = meals[mealIndex]
            result = foodOptions.count
        }
        return result
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell", for: indexPath) as! FoodItemCell
        if meals.count != 0 && mealIndex < meals.count {
            let item : FoodItem = foodOptions[indexPath.row]
            cell.setItem(item: item)
        } else {
            cell.setNoOptions()
        }
        return cell
    }

}
