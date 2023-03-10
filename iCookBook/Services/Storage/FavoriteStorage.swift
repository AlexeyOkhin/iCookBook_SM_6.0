//
//  FavoriteStorage.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import Foundation

class FavoriteStorage {
    
    static let shared = FavoriteStorage()
    var defaults = UserDefaults.standard
    
    private enum Error: Swift.Error {
        case storagePlistWasNotFound
    }
    
    var recipes = [Recipe]()
    private let saveKey = "Favorites"
    
    init() {
        self.recipes = []
    }
    
    func contains(_ recipe: Recipe) -> Bool {
        return recipes.contains { $0.id == recipe.id }
    }
    
    func add(_ recipe: Recipe) {
        recipes.append(recipe)
        save()
    }
    
    func remove(_ recipe: Recipe) {
        recipes.removeAll(where: {$0.id == recipe.id })
        save()
    }
    
    func save() {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipes) {
            defaults.set(encoded, forKey: saveKey)
        }
        
    }
    
    func decode() {
        
        guard let data = defaults.data(forKey: saveKey) else { return }
        
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([Recipe].self, from: data) {
            self.recipes = decodedData
        }
    }
    
}
