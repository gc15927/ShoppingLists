//
//  List.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class List {
    private var name: String = ""
    private var meals: [Meal] = []
    private var ingredients: [Ingredient] = []
    private var date: NSDate = NSDate.init()
    
    func setName(n: String) {
        name = n
    }
    
    func setDate(d: NSDate) {
        date = d
    }
    
    func getName()->String {
        return name
    }
    
    func getDate()->NSDate {
        return date
    }
    
    func addMeal(m: Meal, people: Int) {
        meals.append(m)
        let multiplier = people / m.getServes()
        for i in m.fetchIngredients() {
            i.setQuantity(i.getQuantity()*multiplier)
            addIngredient(i)
        }
    }
    
    func addIngredient(i: Ingredient) {
        for n in ingredients {
            if(n.getName() == i.getName()) {
                n.setQuantity(n.getQuantity()+i.getQuantity())
                return
            }
        }
        ingredients.append(i)
    }
    
    func fetchIngredients()->[Ingredient] {
        return ingredients
    }
    
    
}