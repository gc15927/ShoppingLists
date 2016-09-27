//
//  Ingredient.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class Ingredient: NSObject, NSCoding {
    private var name: String = ""
    private var quantity: Int = 0
    private var quantityType: String = ""
    
    //Properties
    struct PropertyKey {
        static let nameKey = "name"
        static let quantityKey = "quantity"
        static let quantityTypeKey = "quantityType"
    }
    
    //NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeInteger(quantity, forKey: PropertyKey.quantityKey)
        aCoder.encodeObject(quantityType, forKey: PropertyKey.quantityTypeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let quantity = aDecoder.decodeIntegerForKey(PropertyKey.quantityKey)
        let quantityType = aDecoder.decodeObjectForKey(PropertyKey.quantityTypeKey) as! String
        self.init()
        self.name = name
        self.quantity = quantity
        self.quantityType = quantityType
    }
    
    func setName(n: String) {
        name = n
    }
    
    func setQuantity(q: Int) {
        quantity = q
    }
    
    func setQuantityType(qT: String) {
        quantityType = qT
    }
    
    func getName()->String {
        return name
    }
    
    func getQuantity()->Int {
        return quantity
    }
    
    func getQuantityType()->String {
        return quantityType
    }
    
    func printString()->String {
        let name: String = getName()
        let quantity: String = String(getQuantity())
        let quantityType: String = getQuantityType()
        let string: String = (name + " " + quantity + " " + quantityType)
        return string
    }
    
}