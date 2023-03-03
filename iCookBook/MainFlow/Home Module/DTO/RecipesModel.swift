//
//  RecipesModel.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import Foundation

// Mok model
//struct RecipesModel: Decodable {
//    let title: String
//    let urlImage: String
//    let id: Int
//    let isFavorite: Bool
//}

struct SpoonacularModel: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let id: Int
    let title: String
    let image: String?
    let summary: String
    let readyInMinutes: Int
    let extendedIngredients: [ExtendedIngredient]
}

struct ExtendedIngredient: Codable {
    let id: Int
    let name: String
    let original, originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
}
