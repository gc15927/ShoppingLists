//
//  ListModel.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 21/02/2017.
//  Copyright © 2017 Gareth Carless. All rights reserved.
//

import Foundation

class ListModel {
    
    let dataService = DataService()
    var lists = [List]()
    var activeList = List()
    var listNumber = Int()
    
    init() {
        lists = dataService.getLists()
    }
    
    func insertMeal(m: Meal, numPeople: Int) {
        let mealToAdd = adaptMealForList(m, people: numPeople)
        activeList.addMeal(mealToAdd)
        for ing in mealToAdd.getIngredients() {
            print("new ingredient")
            activeList.addIngredient(ing)
        }
    }
    
    func adaptMealForList(_ meal: Meal, people: Int) -> Meal {
        let multiplier = Float(people) / Float(meal.getServes())
        meal.setServes(people)
        var newIngredients: [Ingredient] = [Ingredient]()
        for i in meal.getIngredients() {
            i.setQuantity(i.getQuantity()*multiplier)
            newIngredients.append(i)
        }
        meal.setIngredients(newIngredients)
        
        return meal
    }
    
    func setDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        activeList.setDate(formatter.string(from: date))
    }
    
    func saveList() {
        if(listNumber < lists.count) {
            lists[listNumber] = activeList
        } else {
            lists.append(activeList)
        }
        dataService.saveLists(lists: lists)
    }
    
    func loadList(list: Int) {
        if(list < lists.count) {
            activeList = lists[list]
        }
        listNumber = list
    }
    
    func updateLists() {
        lists = dataService.getLists()
    }
}




