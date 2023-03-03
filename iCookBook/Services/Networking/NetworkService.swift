//
//  NetworkService.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import Foundation

protocol NetworkServicesProtocol {
    func getPopularRecipes(completion: @escaping(Result<SpoonacularModel, Error>) -> Void)
}

final class NetvorkService: NetworkServicesProtocol {

    //MARK: - Private Properties

    private let baseUrl = "https://api.spoonacular.com/recipes/"
    private let random = "random"
    private let request = "?"
    private let apiKey = PrivateConstants.apiKey2

    //MARK: -  Methods

    func getPopularRecipes(completion: @escaping (Result<SpoonacularModel, Error>) -> Void) {

        let urlString = "\(baseUrl)\(random)?/&apiKey=\(apiKey)&number=10&sort=popular"
        print(urlString)
        guard  let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data else { return }

            do {
                let object = try JSONDecoder().decode(SpoonacularModel.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
