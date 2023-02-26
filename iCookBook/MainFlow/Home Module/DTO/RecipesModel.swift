//
//  RecipesModel.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import Foundation

// Mok model
struct RecipesModel: Decodable {
    let title: String
    let urlImage: String
    let id: Int
    let isFavorite: Bool
}
