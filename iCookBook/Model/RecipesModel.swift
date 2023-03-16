//
//  RecipesModel.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import Foundation

struct SpoonacularModel: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String?
    let summary: String
    let readyInMinutes: Int
    let extendedIngredients: [ExtendedIngredient]
    var isFaved: Bool?
    let pricePerServing: Double
    var favButtonColor: FavButtonColor?
}

struct ExtendedIngredient: Codable {
    let id: Int
    let name: String
    let original, originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
}

enum FavButtonColor: String, Codable {
    case clear
    case systemOrange
}
