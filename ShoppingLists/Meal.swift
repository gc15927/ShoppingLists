//
//  Meal.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class Meal: NSObject, NSCoding {
    
    private var name: String = ""
    private var serves: Int  = 0
    private var ingredients: [Ingredient] = []
    
    //Properties
    struct PropertyKey {
        static let nameKey = "name"
        static let servesKey = "serves"
        static let ingredientsKey = "ingredients"
    }
    
    //Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    //NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeInteger(serves, forKey: PropertyKey.servesKey)
        aCoder.encodeObject(ingredients, forKey: PropertyKey.ingredientsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let serves = aDecoder.decodeIntegerForKey(PropertyKey.servesKey)
        let ingredients = aDecoder.decodeObjectForKey(PropertyKey.ingredientsKey) as! [Ingredient]
        self.init()
        self.name = name
        self.serves = serves
        self.ingredients = ingredients
    }
    
    
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








