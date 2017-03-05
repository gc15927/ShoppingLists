//
//  Ingredient.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class Ingredient: NSObject, NSCoding {
    fileprivate var name: String = ""
    fileprivate var quantity: Float = 0
    fileprivate var quantityType: String = ""
    
    //Properties
    struct PropertyKey {
        static let nameKey = "name"
        static let quantityKey = "quantity"
        static let quantityTypeKey = "quantityType"
    }
    
    //NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(quantity, forKey: PropertyKey.quantityKey)
        aCoder.encode(quantityType, forKey: PropertyKey.quantityTypeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let quantity = aDecoder.decodeFloat(forKey: PropertyKey.quantityKey)
        let quantityType = aDecoder.decodeObject(forKey: PropertyKey.quantityTypeKey) as! String
        self.init()
        self.name = name
        self.quantity = quantity
        self.quantityType = quantityType
    }
    
    func setName(_ n: String) {
        name = n
    }
    
    func setQuantity(_ q: Float) {
        quantity = q
    }
    
    func setQuantityType(_ qT: String) {
        quantityType = qT
    }
    
    func getName()->String {
        return name
    }
    
    func getQuantity()->Float {
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
