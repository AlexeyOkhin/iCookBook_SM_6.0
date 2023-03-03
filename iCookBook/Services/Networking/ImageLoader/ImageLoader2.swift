//
//  ImageLoader2.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 02.03.2023.
//

import UIKit

final class ImageLoader2 {
    
    private init() {}
    
    static let shared = ImageLoader2()
    
    static let cache = NSCache<NSString, UIImage>()
    
    let networkManager = NetworkManager()
    
    func fetchImage(for recipe: Recipe, completion: @escaping (UIImage?, NSString?, Error?) -> Void) {
        let cacheKey = NSString(string: recipe.title)
        if let image = ImageLoader2.cache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                completion(image, cacheKey, nil)
            }
            return
        }
        guard let imageUrl = recipe.image else { return }
        
        let httpsURLString = imageUrl.replacingOccurrences(of: "http://", with: "https://") // некоторые фото в апи бывают на http, но имеют https вариант
        guard let url = URL(string: httpsURLString) else { return }
        networkManager.fetchData(with: url) { result in
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(nil, nil, "error" as! Error)
                    return
                }
                ImageLoader2.cache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async {
                    completion(image, cacheKey, nil)
                }
            case .failure(_):
                completion(nil, nil, "error" as! Error)
            }
        }
    }
    
}
