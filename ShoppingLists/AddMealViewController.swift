//
//  AddMealViewController.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import UIKit

class AddMealViewController: UIViewController {
    
    //Array containing ingredients in the meal
    var ingredients: [Ingredient] = []
    //Alert to be displayed to add a new ingredient
    let alert = UIAlertController(title: "Enter Ingredient", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    
    //Button for new ingredient
    @IBOutlet weak var plusButton: UIButton!
    //Textfields for name and serves input
    @IBOutlet weak var servesText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    //Label "Ingredients:", used to retrieve y values for ingredient labels
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create alert controller properties; textfields and cancel/done buttons
        alert.addAction(UIAlertAction(title: "Done", style: .Default){UIAlertAction in self.alertDone()})
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default){UIAlertAction in self.alertCancel()})
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in textField.placeholder = "Ingredient"})
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in textField.placeholder = "Quantity"})
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in textField.placeholder = "Quantity type e.g. grams"})
    }
    
    //Respond to user pressing the cancel button in the navigation bar, only operation
    //needed is to close the view, as no meal data is saved until the done button is pressed
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Respond to user pressing the done button in the navigation bar, generate Meal object
    //and send it to the parent view controller to be added to the list of meals. Also close view
    @IBAction func doneButtonPressed(sender: AnyObject) {
        let newMeal: Meal = Meal()
        for i in ingredients {
            newMeal.addIngredient(i)
        }
        newMeal.setName(nameText.text!)
        newMeal.setServes(Int(servesText.text!)!)
    
        var meals: [Meal] = []
        //Check if meals list already exists
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(Meal.ArchiveURL.path!) {
            //No meals saved
            meals = [newMeal]
        }
        else {
            //Add new meal to list of meals
            var meals = NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
            meals?.append(newMeal)
        }
        //Save meals
        let successfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        if !successfulSave {
            print("Unable to save meals")
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //User presses button to add new ingredient, display the pre-formed alert
    @IBAction func addIngredient(sender: AnyObject) {
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //Alert done button pressed. Pull variables for new ingredient from the alert text fields,
    //create new ingredient, display, and add to list of ingredients. Clear text fields.
    func alertDone() {
        let inName: String = alert.textFields![0].text!
        let inQuant: String = alert.textFields![1].text!
        let inQuantType = alert.textFields![2].text!
        let newIngredient: Ingredient = Ingredient()
        newIngredient.setName(inName)
        newIngredient.setQuantity(Int(inQuant)!)
        newIngredient.setQuantityType(inQuantType)
        ingredients.append(newIngredient)
        alert.textFields![0].text! = ""
        alert.textFields![1].text! = ""
        alert.textFields![2].text! = ""
        displayNewIngredient(newIngredient)
    }
    
    //Display new ingredient after alert view closed; calculate y value for the new label, get
    //print value for the ingredient and then add to the view.
    func displayNewIngredient(i: Ingredient) {
        let newLabel: UILabel = UILabel.init(frame: ingredientsLabel.frame)
        newLabel.frame.origin.x = servesText.frame.origin.x
        newLabel.frame.size = CGSize.init(width: servesText.frame.width, height: newLabel.frame.height)
        if(ingredients.count == 1) {
            newLabel.frame.origin.y = ingredientsLabel.frame.origin.y
        }
        else {
            newLabel.frame.origin.y += CGFloat(30*(ingredients.count-1))
        }
        newLabel.text = i.printString()
        self.view.addSubview(newLabel)
    }
    
    
    //Alert cancelled, no functionality needed
    func alertCancel() {
        
    }
}