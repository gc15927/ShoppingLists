//
//  AddListViewController.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 03/10/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Respond to user pressing the cancel button in the navigation bar, only operation
    //needed is to close the view, as no meal data is saved until the done button is pressed
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Respond to user pressing the done button in the navigation bar, generate Meal object
    //and send it to the parent view controller to be added to the list of meals. Also close view
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
