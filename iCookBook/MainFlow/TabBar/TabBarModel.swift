//
//  TabBarModel.swift
//  
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

enum TabBarModel {
    struct TabProperties {
        let title: String
        let image: UIImage
    }
    case home
    case favorite
    case search
    case categories
    
    var properties: TabProperties {
        switch self {
        case .home:
            return TabProperties(title: "Популярные", image: UIImage(systemName: "list.bullet.rectangle")!)
        case .favorite:
            return TabProperties(title: "Избранное", image: UIImage(systemName: "heart.fill")!)
        case .search:
            return TabProperties(title: "Поиск", image: UIImage(systemName: "magnifyingglass")!)
        case.categories:
            return TabProperties(title: "Категории", image: UIImage(systemName: "line.3.horizontal")!)
        }
    }
}

