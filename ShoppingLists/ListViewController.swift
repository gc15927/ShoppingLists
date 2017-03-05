//
//  ListViewController.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 08/02/2017.
//  Copyright © 2017 Gareth Carless. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var listNumber = Int()
    var list = List()
    var ingredients = [Ingredient]()
    var meals = [Meal]()
    let dataService = DataService()
    
    @IBOutlet weak var ingredientsTable: UITableView!
    @IBOutlet weak var mealsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ingredientsTable.delegate = self
        ingredientsTable.dataSource = self
        mealsTable.delegate = self
        mealsTable.dataSource = self
        
        //Load lists from memory, fill tables with data from relevant list
        var lists = dataService.getLists()
        list = lists[listNumber]
        ingredients = list.getIngredients()
        meals = list.getMeals()
        
        mealsTable.reloadData()
        ingredientsTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setListIndex(_ listNo: Int) {
        listNumber = listNo
    }
    
    func refreshTables() {
        mealsTable.reloadData()
        ingredientsTable.reloadData()
    }
    
    @IBAction func edit(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddListViewController") as! AddListViewController
        controller.setList(listNo: listNumber)
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(tableView.restorationIdentifier!) {
        case "meals":
            return meals.count
        case "items":
            return ingredients.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView.restorationIdentifier == "meals") {
            let cellIdentifier = "MealTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)    as! MealTableViewCell
            
            // Configure the cell...
            let meal = meals[(indexPath as NSIndexPath).row]
            
            cell.nameLabel.text = meal.getName()
            cell.servesLabel.text = (String(meal.getServes()) + " People")
            return cell
        }
        else {
            let cellIdentifier = "IngredientTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)    as! IngredientTableViewCell
            
            // Configure the cell...
            let ingredient = ingredients[(indexPath as NSIndexPath).row]
            
            cell.nameLabel.text = ingredient.getName()
            cell.quantityLabel.text = (String(ingredient.getQuantity()) + " " + String(ingredient.getQuantityType()))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    
}
