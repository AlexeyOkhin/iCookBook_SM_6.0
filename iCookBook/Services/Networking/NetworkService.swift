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

final class NetworkService: NetworkServicesProtocol {

    //MARK: - Private Properties
    
    private let baseUrl = "https://api.spoonacular.com/recipes/"
    private let request = "?"
    private let random = "random"
    private let complexSearch = "complexSearch"
    private let apiKey = PrivateConstants.apiKey2
    //MARK: -  Methods
    
    func getPopularRecipes(completion: @escaping (Result<SpoonacularModel, Error>) -> Void) {

        let urlString = "\(baseUrl)\(random)?/&apiKey=\(apiKey)&number=20&sort=popular"
        print(urlString)
        guard let url = URL(string: urlString) else { return }

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


    func getRecipesByQuery(query: String, completion: @escaping (Result<SpoonacularModel, Error>) -> Void) {

        let urlString = "\(baseUrl)/\(random)?/&apiKey=\(apiKey)&tags=\(query.lowercased())&number=20&sort=popular"
        print(urlString)
        guard let url = URL(string: urlString) else { return }

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
    
//
//    func getAllRecipes(completion: @escaping (Result<RecipeResults, Error>) -> Void) {
//
//        let urlString = "\(baseUrl)/\(complexSearch)?&apiKey=\(apiKey)&addRecipeInformation=true"
//        guard let url = URL(string: urlString) else { return }
//        print(url)
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data else { return }
//
//            do {
//                let object = try JSONDecoder().decode(RecipeResults.self, from: data)
//                completion(.success(object))
//            } catch {
//                completion(.failure(error))
//                print("ERROR")
//            }
//        }.resume()
//    }

    
}
