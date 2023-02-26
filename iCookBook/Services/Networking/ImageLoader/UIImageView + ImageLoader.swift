//
//  UIImageView + ImageLoader.swift
//  Tinkoff-Test
//
//  Created by Djinsolobzik on 04.02.2023.
//

import UIKit

extension UIImageView {
    
    func loadImage(from stringUrl: String) {
        ImageLoader().loadImage(from: stringUrl) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
        
    }
}
