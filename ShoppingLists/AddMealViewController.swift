//
//  AddMealViewController.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import UIKit

class AddMealViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Alert to be displayed to add a new ingredient
    let alert = UIAlertController(title: "Enter Ingredient", message: nil, preferredStyle: UIAlertControllerStyle.alert)
    let mealModel = MealModel()
    var mealSet = false
    
    //Button for new ingredient
    @IBOutlet weak var plusButton: UIButton!
    //Textfields for name and serves input
    @IBOutlet weak var servesText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ingredientsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view, typically from a nib.
        ingredientsTable.delegate = self
        ingredientsTable.dataSource = self
        if(!mealSet) {
            setMeal(mealNumber: mealModel.meals.count)
        }
        initAlert()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(mealSet) {
            nameText.text = mealModel.activeMeal.getName()
            servesText.text = String(mealModel.activeMeal.getServes())
        }
    }
    
    func initAlert() {
        //Create alert controller properties; textfields and cancel/done buttons
        alert.addAction(UIAlertAction(title: "Done", style: .default){UIAlertAction in self.alertDone()})
        alert.addAction(UIAlertAction(title: "Cancel", style: .default){UIAlertAction in self.alertCancel()})
        alert.addTextField(configurationHandler: {(textField: UITextField!) in textField.placeholder = "Ingredient"})
        alert.addTextField(configurationHandler: {(textField: UITextField!) in textField.placeholder = "Quantity"})
        alert.addTextField(configurationHandler: {(textField: UITextField!) in textField.placeholder = "Quantity type e.g. grams"})
    }
    
    //Respond to user pressing the cancel button in the navigation bar, only operation
    //needed is to close the view, as no meal data is saved until the done button is pressed
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Respond to user pressing the done button in the navigation bar, generate Meal object
    //and send it to the parent view controller to be added to the list of meals. Also close view
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        mealModel.activeMeal.setName(nameText.text!)
        mealModel.activeMeal.setServes(Int(servesText.text!)!)
        mealModel.saveMeal()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setMeal(mealNumber: Int) {
        mealModel.loadMeal(meal: mealNumber)
        mealSet = true
    }
    
    
    //User presses button to add new ingredient, display the pre-formed alert
    @IBAction func addIngredient(_ sender: AnyObject) {
        self.present(alert, animated: true, completion: nil)
    }
    
    //Alert done button pressed. Pull variables for new ingredient from the alert text fields,
    //create new ingredient, display, and add to list of ingredients. Clear text fields.
    func alertDone() {
        let inName: String = alert.textFields![0].text!
        let inQuant: String = alert.textFields![1].text!
        let inQuantType = alert.textFields![2].text!
        let newIngredient: Ingredient = Ingredient()
        newIngredient.setName(inName)
        newIngredient.setQuantity(Float(inQuant)!)
        newIngredient.setQuantityType(inQuantType)
        mealModel.activeMeal.addIngredient(newIngredient)
        ingredientsTable.reloadData()
        
        alert.textFields![0].text! = ""
        alert.textFields![1].text! = ""
        alert.textFields![2].text! = ""
    }
    
    //Alert cancelled, no functionality needed
    func alertCancel() {}
    
    
    
    // Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealModel.activeMeal.getIngredients().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "IngredientTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! IngredientTableViewCell
        
        // Configure the cell...
        let ingredient = mealModel.activeMeal.getIngredients()[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = ingredient.getName()
        cell.quantityLabel.text = (String(ingredient.getQuantity()) + " " + ingredient.getQuantityType())
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        controller.setListIndex(indexPath.item)
        self.present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
