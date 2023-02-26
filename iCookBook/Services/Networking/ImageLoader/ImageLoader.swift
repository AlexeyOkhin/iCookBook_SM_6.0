//
//  ImageLoader.swift
//
//
//  Created by Djinsolobzik on 04.02.2023.
//
import UIKit

struct ImageLoader {

    let queueForLoad = DispatchQueue.global(qos: .utility)
    let session = URLSession(configuration: .default)

    func loadImage(from stringUrl: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let url = URL(string: stringUrl) {
            session.dataTask(with: url) { data, _, error in

                if let error = error {
                    completion(.failure(error))
                }
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }.resume()
        } 
    }
}
