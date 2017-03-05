//
//  DataService.swift
//  ShoppingLists
//
//  Created by Gareth Carless on 19/02/2017.
//  Copyright © 2017 Gareth Carless. All rights reserved.
//

import Foundation

class DataService {
    
    let fileManager = FileManager.default
    
    public func getListWithName(name: String)->List? {
        if !fileManager.fileExists(atPath: List.ArchiveURL.path) {
            //No lists saved
            return nil
        }
        else {
            let lists = NSKeyedUnarchiver.unarchiveObject(withFile: List.ArchiveURL.path) as! [List]
            //Search through lists for the one named
            for l in lists {
                if l.getName() == "name" {
                    return l
                }
            }
        }
        //No list with name
        return nil
    }
    
    public func saveList(list: List) {
        var lists: [List]
        if !fileManager.fileExists(atPath: List.ArchiveURL.path) {
            //No lists saved
            lists = [list]
        }
        else {
            //Append list
            lists = NSKeyedUnarchiver.unarchiveObject(withFile: List.ArchiveURL.path) as! [List]
            lists.append(list)
        }
        //Save updated lists
        let successfulSave = NSKeyedArchiver.archiveRootObject(lists, toFile: List.ArchiveURL.path)
        if !successfulSave {
            print("Unable to save lists")
        }
    }
    
    public func getLists()->[List] {
        if !fileManager.fileExists(atPath: List.ArchiveURL.path) {
            //No lists saved
            return []
        }
        else {
            let lists = NSKeyedUnarchiver.unarchiveObject(withFile: List.ArchiveURL.path) as! [List]
            return lists
        }
    }
    
    public func saveLists(lists: [List]) {
        let successfulSave = NSKeyedArchiver.archiveRootObject(lists, toFile: List.ArchiveURL.path)
        if !successfulSave {
            print("Unable to save lists")
        }
    }
    
    public func getMealWithName(name: String)->Meal? {
        if !fileManager.fileExists(atPath: Meal.ArchiveURL.path) {
            //No meals saved
            return nil
        }
        else {
            let meals = NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as! [Meal]
            //Search through meals for the one named
            for m in meals {
                if m.getName() == "name" {
                    return m
                }
            }
        }
        //No meal with name
        return nil
    }
    
    public func saveMeal(meal: Meal) {
        var meals: [Meal]
        if !fileManager.fileExists(atPath: Meal.ArchiveURL.path) {
            //No meals saved
            meals = [meal]
        }
        else {
            //Append list
            meals = NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as! [Meal]
            meals.append(meal)
        }
        //Save updated lists
        let successfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if !successfulSave {
            print("Unable to save lists")
        }
    }
    
    public func getMeals()->[Meal] {
        if !fileManager.fileExists(atPath: Meal.ArchiveURL.path) {
            //No meals saved
            return []
        }
        else {
            let meals = NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as! [Meal]
            return meals
        }
    }
    
    public func saveMeals(meals: [Meal]) {
        let successfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if !successfulSave {
            print("Unable to save meals")
        }
    }
    
}
