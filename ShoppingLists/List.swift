//
//  List.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class List: NSObject, NSCoding {
    fileprivate var name: String = String()
    fileprivate var meals: [Meal] = []
    fileprivate var ingredients: [Ingredient] = []
    fileprivate var date: String = String()
    
    func setName(_ n: String) {
        name = n
    }
    
    func setDate(_ d: String) {
        date = d
    }
    
    func getName()->String {
        return name
    }
    
    func getDate()->String {
        return date
    }
    
    func addMeal(_ m: Meal) {
        meals.append(m)
    }
    
    func addIngredient(_ i: Ingredient) {
        for n in ingredients {
            if(n.getName() == i.getName()) {
                print(n.getQuantity())
                print(i.getQuantity())
                let newQuantity = n.getQuantity()+i.getQuantity()
                n.setQuantity(newQuantity)
                //print(newQuantity)
                return
            }
        }
        ingredients.append(i)
    }
    
    func getIngredients()->[Ingredient] {
        return ingredients
    }
    
    func getMeals()->[Meal] {
        return meals
    }
    
    func setIngredients(ings: [Ingredient]) {
        ingredients = ings
    }
    
    func setMeals(ms: [Meal]) {
        meals = ms
    }
    
    
    //Coding
    
    //Properties
    struct PropertyKey {
        static let nameKey = "name"
        static let dateKey = "date"
        static let mealsKey = "meals"
        static let ingredientsKey = "ingredients"
    }
    
    //Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("lists")
    
    //NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(date, forKey: PropertyKey.dateKey)
        aCoder.encode(meals, forKey: PropertyKey.mealsKey)
        aCoder.encode(ingredients, forKey: PropertyKey.ingredientsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let date = aDecoder.decodeObject(forKey: PropertyKey.dateKey) as! String
        let meals = aDecoder.decodeObject(forKey: PropertyKey.mealsKey) as! [Meal]
        let ingredients = aDecoder.decodeObject(forKey: PropertyKey.ingredientsKey) as! [Ingredient]
        self.init()
        self.name = name
        self.date = date
        self.meals = meals
        self.ingredients = ingredients
    }

    
    
}
