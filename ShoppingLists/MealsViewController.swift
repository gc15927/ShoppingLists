//
//  MealsViewController.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import UIKit

class MealsViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Load meals from memory, fill table view with them
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

