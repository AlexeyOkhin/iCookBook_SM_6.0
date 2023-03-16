//
//  NetworkManager.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 02.03.2023.
//

import Foundation

protocol NetworkRouting {
    func fetchData(with url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManager: NetworkRouting {

    func fetchData(with url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(error!))
                return
            }

            guard let data = data else { return }
            completion(.success(data))
        }
        task.resume()
    }
}
