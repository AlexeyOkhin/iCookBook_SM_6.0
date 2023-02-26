//
//  NetworkService.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import Foundation

protocol NetworkServicesProtocol {
    func getPopularRecipes(completion: @escaping(Result<RecipesModel?, Error>) -> Void)
}

final class NetvorkService: NetworkServicesProtocol {

    //MARK: - Private Properties

    private let baseUrl = "https://api.spoonacular.com/recipes/"
    private let request = "?"
    private let apiKey = "??"

    //MARK: -  Methods

    func getPopularRecipes(completion: @escaping (Result<RecipesModel?, Error>) -> Void) {

        let urlString = "\(baseUrl)\(request)/&apiKey=\(apiKey)"
        guard  let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data else { return }

            do {
                let object = try JSONDecoder().decode(RecipesModel.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
