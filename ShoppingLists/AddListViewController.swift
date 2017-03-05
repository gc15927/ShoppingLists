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
    
    let listModel = ListModel()
    let mealModel = MealModel()
    var listSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(!listSet) {
            setList(listNo: listModel.lists.count)
        }
        //Load meals from memory, fill table view with them
        mealsPicker.isHidden = true
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
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        if(saveButton.title == "Save") {
            //Close add list view
            self.dismiss(animated: true, completion: nil)
            listSet = false
        }
        else {
            //Close mealPicker
            saveButton.title = "Save"
            mealsPicker.isHidden = true
        }
    }
    
    //Respond to user pressing the done button in the navigation bar, generate Meal object
    //and send it to the parent view controller to be added to the list of meals. Also close view.
    //Or add meal to list.
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        if(saveButton.title == "Save") {
            //Save list
            listModel.activeList.setName("New List")
            listModel.setDate()
            listModel.saveList()
            self.dismiss(animated: true, completion: nil)
            listSet = false
        }
        else {
            //Add meal to list of meals
            saveButton.title = "Save"
            mealsPicker.isHidden = true
            let meal = mealModel.meals[mealsPicker.selectedRow(inComponent: 0)-1]
            let num = mealsPicker.selectedRow(inComponent: 1)
            listModel.insertMeal(m: meal, numPeople: num)
            mealsTable.reloadData()
            itemsTable.reloadData()
        }
    }
    
    @IBAction func addMeal(_ sender: AnyObject) {
        mealsPicker.isHidden = false
        mealsPicker.alpha = 1.0
        saveButton.title = "Add"
    }
    
    @IBAction func addItem(_ sender: AnyObject) {
        
    }
    
    func setList(listNo: Int) {
        listModel.loadList(list: listNo)
        listSet = true
    }
    
    //PICKER
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0) {
            return mealModel.meals.count + 1
        }
        else {
            return 13
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) {
            if(row == 0) {
                return "Meal"
            }
            else {
                return mealModel.meals[row-1].getName()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(tableView.restorationIdentifier!) {
            case "meals":
                return listModel.activeList.getMeals().count
            case "items":
                return listModel.activeList.getIngredients().count
            default:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
        
        // Configure the cell...
        switch(tableView.restorationIdentifier!) {
        case "meals":
            let meal = listModel.activeList.getMeals()[(indexPath as NSIndexPath).row]
            cell.nameLabel.text = (meal.getName() + ": " + String(meal.getServes()) + " people")
            break
        case "items":
            let item = listModel.activeList.getIngredients()[(indexPath as NSIndexPath).row]
            cell.nameLabel.text = (item.getName() + ": " + String(item.getQuantity()) + " " + item.getQuantityType())
            break
        default:
            break
        }
        
        return cell
    }
    
}
