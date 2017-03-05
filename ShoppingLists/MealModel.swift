//
//  MealsModel.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 21/02/2017.
//  Copyright © 2017 Gareth Carless. All rights reserved.
//

import Foundation

class MealModel {
    
    let dataService = DataService()
    var meals = [Meal]()
    var activeMeal = Meal()
    var mealNumber = Int()

    
    init() {
        meals = dataService.getMeals()
    }
    
    func saveMeal() {
        if(mealNumber < meals.count) {
            meals[mealNumber] = activeMeal
        } else {
            meals.append(activeMeal)
        }
        dataService.saveMeals(meals: meals)
    }
    
    func loadMeal(meal: Int) {
        if(meal < meals.count) {
            activeMeal = meals[meal]
        }
        mealNumber = meal
    }
    
    func updateMeals() {
        meals = dataService.getMeals()
    }


}
