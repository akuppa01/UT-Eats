//
//  ViewController.swift
//  UT Eats
//
//  Created by Aditya Kuppa on 2/16/20.
//  Copyright © 2020 Aditya Kuppa. All rights reserved.
//
import UIKit
import SwiftSoup
import Foundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myIndex = 0
    var diningOptions = [[String]]()

    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        diningOptions = DiningOptions().getOptions()
        myTableView.dataSource = self
        myTableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return diningOptions.count
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "DiningOptionsCell") as! DiningOptionsCell
         let title = diningOptions[indexPath.row][0]
         cell.setOption(option: title)
         
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dvc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        dvc?.setText(ttl: "\(diningOptions[indexPath.row][0])", link: "\(diningOptions[indexPath.row][1])", index: indexPath.row)
        self.navigationController?.pushViewController(dvc!, animated: true)
       // self.performSegue(withIdentifier: "segue", sender: nil)
    }
}

