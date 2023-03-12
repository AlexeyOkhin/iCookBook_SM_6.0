//
//  CategoryModel.swift
//  iCookBook
//
//  Created by Aleksey Kosov on 11.03.2023.
//

import UIKit

struct CategoryModel: Hashable {
    let id = UUID()
    let title: String
    let image: UIImage?


    static let categoryModels = [
        CategoryModel(title: "Pasta", image: UIImage(named: "pasta")),
        CategoryModel(title: "Seafood", image: UIImage(named: "seafood")),
        CategoryModel(title: "Fruits", image: UIImage(named: "fruits")),
        CategoryModel(title: "Snacks", image: UIImage(named: "snacks")),
        CategoryModel(title: "Eggs", image: UIImage(named: "eggs")),
        CategoryModel(title: "Vegetables", image: UIImage(named: "vegetables")),
        CategoryModel(title: "Seafood", image: UIImage(named: "seafood")),
        CategoryModel(title: "Desserts", image: UIImage(named: "desserts")),
        CategoryModel(title: "Pizza", image: UIImage(named: "pizza")),
        CategoryModel(title: "Soup", image: UIImage(named: "soup"))
    ]
}
