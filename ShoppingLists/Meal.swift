//
//  Meal.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class Meal: NSObject, NSCoding {
    
    fileprivate var name: String = ""
    fileprivate var serves: Int  = 0
    fileprivate var ingredients: [Ingredient] = []
    
    //Properties
    struct PropertyKey {
        static let nameKey = "name"
        static let servesKey = "serves"
        static let ingredientsKey = "ingredients"
    }
    
    //Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(serves, forKey: PropertyKey.servesKey)
        aCoder.encode(ingredients, forKey: PropertyKey.ingredientsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let serves = aDecoder.decodeInteger(forKey: PropertyKey.servesKey)
        let ingredients = aDecoder.decodeObject(forKey: PropertyKey.ingredientsKey) as! [Ingredient]
        self.init()
        self.name = name
        self.serves = serves
        self.ingredients = ingredients
    }
    
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    func getIngredients()->[Ingredient] {
        return ingredients
    }
    
    func setIngredients(_ newIngredients: [Ingredient]) {
        ingredients = newIngredients
    }
    
    func setName(_ n: String) {
        name = n
    }
    
    func setServes(_ s: Int) {
        serves = s
    }
    
    func getName()->String {
        return name
    }
    
    func getServes()->Int {
        return serves
    }
    

}








