//
//  Meal.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class Meal {
    private var name: String = ""
    private var serves: Int  = 0
    private var ingredients: [Ingredient] = []
    
    func addIngredient(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    func fetchIngredients()->[Ingredient] {
        return ingredients
    }
    
    func setName(n: String) {
        name = n
    }
    
    func setServes(s: Int) {
        serves = s
    }
    
    func getName()->String {
        return name
    }
    
    func getServes()->Int {
        return serves
    }
    
}