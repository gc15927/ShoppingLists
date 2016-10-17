//
//  AddListViewController.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 03/10/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var itemsTable: UITableView!
    @IBOutlet weak var mealsTable: UITableView!
    @IBOutlet weak var mealsPicker: UIPickerView!
    
    var meals = [Meal]()
    var items = [Ingredient]()
    var existingMeals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Load meals from memory, fill table view with them
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(Meal.ArchiveURL.path!) {
            //No meals saved
        }
        else {
            //Add new meal to list of meals
            existingMeals = NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as! [Meal]
        }
        mealsPicker.hidden = true
        mealsPicker.delegate = self
        mealsPicker.dataSource = self
        
        mealsTable.delegate = self
        mealsTable.dataSource = self
        itemsTable.delegate = self
        itemsTable.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Respond to user pressing the cancel button in the navigation bar, only operation
    //needed is to close the view, as no meal data is saved until the done button is pressed
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        if(saveButton.title == "Save") {
            //Close add list view
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            //Close mealPicker
            saveButton.title = "Save"
            mealsPicker.hidden = true
        }
    }
    
    //Respond to user pressing the done button in the navigation bar, generate Meal object
    //and send it to the parent view controller to be added to the list of meals. Also close view.
    //Or add meal to list.
    @IBAction func saveButtonPressed(sender: AnyObject) {
        if(saveButton.title == "Save") {
            //Save list
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            //Add meal to list of meals
            saveButton.title = "Save"
            mealsPicker.hidden = true
            let mealToAdd = existingMeals[mealsPicker.selectedRowInComponent(0)-1]
            let numberOfPeople = mealsPicker.selectedRowInComponent(1)
            meals.append(adaptMealForList(mealToAdd, people: numberOfPeople))
            mealsTable.reloadData()
        }
    }
    
    @IBAction func addMeal(sender: AnyObject) {
        mealsPicker.hidden = false
        saveButton.title = "Add"
    }

    @IBAction func addItem(sender: AnyObject) {
    
    }
    
    func adaptMealForList(meal: Meal, people: Int) -> Meal {
        let multiplier = people / meal.getServes()
        meal.setServes(people)
        var newIngredients: [Ingredient] = [Ingredient]()
        for i in meal.fetchIngredients() {
            i.setQuantity(i.getQuantity()*multiplier)
            newIngredients.append(i)
        }
        meal.setIngredients(newIngredients)
        
        return meal
    }
    
    //PICKER
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0) {
            return existingMeals.count + 1
        }
        else {
            return 13
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) {
            if(row == 0) {
                return "Meal"
            }
            else {
                return existingMeals[row-1].getName()
            }
        }
        else {
            if(row == 0) {
                return "People"
            }
            else {
                return String(row)
            }
        }
    }
    
    
    //TABLE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(tableView.restorationIdentifier!) {
            case "meals":
                return meals.count
            case "items":
                return items.count
            default:
                return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        // Configure the cell...
        switch(tableView.restorationIdentifier!) {
        case "meals":
            let meal = meals[indexPath.row]
            cell.nameLabel.text = (meal.getName() + ": " + String(meal.getServes()) + " people")
            break
        case "items":
            break
        default:
            break
        }
        
        return cell
    }
    
}
