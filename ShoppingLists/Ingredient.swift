//
//  Ingredient.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 23/09/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation

class Ingredient {
    private var name: String = ""
    private var quantity: Int = 0
    private var quantityType: String = ""
    
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