//
//  FavoriteStorage.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import UIKit
import Foundation

//TODO: поправить нейминг под кухню

class FavoriteStorage {
    
    static let shared = FavoriteStorage()

    //MARK: - Nested Types
    
    private enum Error: Swift.Error {
        case storagePlistWasNotFound
    }

    //MARK: - Private Properties
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
        
    }
    
}

//class FavoriteStorage {
//
//    //MARK: - Nested Types
//
//    private enum Error: Swift.Error {
//        case storagePlistWasNotFound
//    }
//
//    //MARK: - Private Properties
//
//    private let storage: UserDefaults
//    private let favoritesKeyInStorage = "FavoritePictures"
//    private let suiteName = "com.favorite.images"
//
//    //MARK: -  Initialization
//
//    init() throws {
//        guard let storage = UserDefaults(suiteName: suiteName) else {
//            throw Error.storagePlistWasNotFound
//        }
//        self.storage = storage
//    }
//
//    //MARK: - Internal Methods
//
//    func saveFavoriteStatus(by id: String, new isFavoriteStatus: Bool) {
//        var allOfFavorites = getAllOfFavorites()
//        if isFavoriteStatus {
//            allOfFavorites.insert(id)
//        }   else {
//            allOfFavorites.remove(id)
//        }
//        writeFavoriteIntoStorage(newFavorites: allOfFavorites)
//    }
//
//    func getIsFavoriteStatus(by id: String) -> Bool {
//        let allOfFavorites = getAllOfFavorites()
//        return allOfFavorites.contains(id)
//    }
//
//    func getAllOfFavorites() -> Set<String> {
//        guard
//            let data = storage.value(forKey: favoritesKeyInStorage) as? Data,
//            let decodeData = try? JSONDecoder().decode(Set<String>.self, from: data)
//        else {
//            return []
//        }
//        return decodeData
//    }
//
//    func writeFavoriteIntoStorage(newFavorites: Set<String>) {
//        guard let encodeData = try? JSONEncoder().encode(newFavorites) else {
//            return
//        }
//        storage.set(encodeData, forKey: favoritesKeyInStorage)
//    }
//
//    func resetFavoriteStorage() {
//
//        storage.removeObject(forKey: favoritesKeyInStorage)
//        storage.removeSuite(named: suiteName)
//
//    }
//}
