//
//  Meals.swift
//  UI-UtraFitApp
//
//  Created by Valentin Malissen on 2020-08-02.
//

import SwiftUI

enum MealCategory: String, CaseIterable {
    case Breakfast = "Breakfast"
    case Lunch = "Lunch"
    case Dinner = "Dinner"
}

struct Ingredient: Hashable {
    var name: String
    var unit: String
    var quantity: Float
}

struct Meal {
    var id = UUID()
    var category: MealCategory
    var imageName: String
    var name: String
    var calories: Int
    var preparationDuration: Int

    var protein: Float
    var fat: Float
    var carbs: Float

    var ingredients: [Ingredient]
    var directions: [String]
}


let meals = [
    Meal(category: .Dinner, imageName: "meals_01", name: "Apple Cider Vinegar", calories: 346, preparationDuration: 15, protein: 35.5, fat: 18.5, carbs: 75, ingredients: [], directions: []),
    Meal(category: .Breakfast, imageName: "meals_02", name: "Breakfast Casserole", calories: 367, preparationDuration: 20, protein: 35.5, fat: 18.5, carbs: 75, ingredients: [], directions: []),
    Meal(category: .Breakfast, imageName: "meals_03", name: "Smoked Salmon Eggs Benedict", calories: 405, preparationDuration: 20, protein: 35.5, fat: 18.5, carbs: 75, ingredients: [Ingredient(name: "Salmon", unit: "", quantity: 1), Ingredient(name: "Olive Oil", unit: "cu", quantity: 1), Ingredient(name: "Asparagus", unit: "g", quantity: 40)], directions: ["Place salmon filets in a row down the center of your bakin pan.", "Arrange trimmed asparagus on the sides of the salmon. Drizzle asparagus lightly with olive oil.", "Sprinkle both asparagus and salmon with salt and pepper."]),
    Meal(category: .Lunch, imageName: "meals_04", name: "Chai Baked Oatmeal", calories: 435, preparationDuration: 15, protein: 35.5, fat: 18.5, carbs: 75, ingredients: [], directions: []),
    Meal(category: .Lunch, imageName: "meals_05", name: "Chai Oatmeal", calories: 298, preparationDuration: 12, protein: 35.5, fat: 18.5, carbs: 75, ingredients: [], directions: []),
    Meal(category: .Lunch, imageName: "meals_06", name: "Oatmeal", calories: 345, preparationDuration: 9, protein: 35.5, fat: 18.5, carbs: 75, ingredients: [], directions: []),
]
