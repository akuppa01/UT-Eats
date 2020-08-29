//
//  DiningOptions.swift
//  UT Menu
//
//  Created by Aditya Kuppa on 3/16/20.
//  Copyright © 2020 Aditya Kuppa. All rights reserved.
//

import Foundation
import SwiftSoup
import UIKit

class DiningOptions {

    let diningOptionsLink = "http://hf-food.austin.utexas.edu/foodpro/location.aspx"
    var diningOptions = [[String]]()
    var meals = [[FoodItem]]()
    
    init() {
        
        do {
            //diningOptionsLink's html sotred in a doc
            let mainDoc: Document = try getHTMLDoc(link: diningOptionsLink)
            //Dictionary with options and respective links
            diningOptions = try getDiningOptions(doc: mainDoc)
                   
        } catch {
            print("error")
        }
    }
    
    func getMeals(index: Int) -> [[FoodItem]] {
        do {
            let selectedOptionLink : String = diningOptions[index][1]
            let subDoc: Document = try getHTMLDoc(link: selectedOptionLink)
            try getFoodOptions(doc: subDoc)
        } catch {
            print("No site/foodOptions found")
        }
        return meals
    }
    
 
    //parses through the doc to find food options
    //returns a Dictionary with the name and link for each restaurant
    func getFoodOptions(doc: Document) throws {
        //parse through the doc to find food options
        let cols = try doc.select("tr[height=5]")
        var itemIndex = 1
        for col in cols {
            var mealOptions = [FoodItem]()
            let rows = try col.select("tr")
            for row in rows {
                let text : String = try row.text()
                let images = try row.select("img[src]")
                var list = [String]()
                for image in images {
                    let imgName = try image.attr("src")
                    list.append(imgName)
                }
                let noRepeats : Bool = text != mealOptions.last?.getName()
                if images.count <= 20 && noRepeats {
                    mealOptions.append(FoodItem(name: text, properties: list))
                    print("\(itemIndex))  \(text)  images: \(list.count)")
                    itemIndex += 1
                }
            }
            meals.append(mealOptions)
        }
        print("*** DONE ***")
        
        for meal in meals {
            for item in meal {
                print("\(item.getName()) \(item.getProperties().count)")
            }
            print("**************")
        }

    }
    
    
    
    func getOptions() -> [[String]] {
         return diningOptions
    }
     
    
    //gets the HTML code for the link and returns it in a Document
    func getHTMLDoc(link: String) throws -> Document {
        //---------> fix the error handling system in this function
        guard let myURL = URL(string: link)
            else { print("Link not working"); throw NetworkError.linkMalfunction }
        let html = try! String(contentsOf: myURL, encoding: .utf8)
        let doc: Document = try SwiftSoup.parse(html)
        return doc
    }
   
    //parses through the doc to find dining options
    //returns a Dictionary with the name and link for each restaurant
    func getDiningOptions(doc: Document) throws -> Array<[String]> {
        let baseURL = "http://hf-food.austin.utexas.edu/foodpro/"
        var diningOptions = [[String]]() //2D array of options
        //parse through the doc to find dining options
        let bodyHTML = try doc.select("td[valign=top]")
        let bodyHTML2 = try bodyHTML.select("span")
        let body = try bodyHTML2.select("a").array()
       
        //loops through the options, adds them to diningOptions prints their name and link
        var index = 1
        for item in body {
            let text : String = try item.text()
            let link = baseURL + "\(try item.attr("href"))"
            diningOptions.append(["\(text)", "\(link)"])
            //print("\(index) " + text + " \(link)")
            index += 1
        }
        return diningOptions
    }
    
    

}


//stores different types of errors pertaining to the app
enum NetworkError: Error {
    case linkMalfunction
}

