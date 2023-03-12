//
//  ViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 25.02.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var tableView: UITableView!
    private var requestFailed: Bool?
    
    var recipesArray = [Recipe]()
    
    let networkService = NetworkService()
    
    var category: CategoryModel?
    
    convenience init(category: CategoryModel) {
        self.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationTitle()
        configureTableView()
        getRecipes()
        setupLayout()
    }
    
    
    private func configureNavigationTitle() {
        if let category {
            title = "\(category.title)"
        } else {
            title = "Popular Recipes"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.cellId)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func getRecipes() {
        if let category {
            networkService.getRecipesByQuery(query: category.title) { result in
                switch result {
                case .success(let spoonacularModel):
                    DispatchQueue.main.async {
                        self.recipesArray = spoonacularModel.recipes
                        self.tableView.reloadData()
                    }
                case .failure:
                    self.requestFailed = true
                }
            }
        } else {
            networkService.getPopularRecipes { result in
                switch result {
                case .success(let spoonacularModel):
                    DispatchQueue.main.async {
                        self.recipesArray = spoonacularModel.recipes
                        self.tableView.reloadData()
                    }
                case .failure:
                    self.requestFailed = true
                }
            }
        }
    }
}




extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.configure(recipe: recipesArray[indexPath.row])
        present(vc, animated: true)
    }
    
}




extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.cellId, for: indexPath) as! RecipeTableViewCell
        let recipe = recipesArray[indexPath.row]
        cell.configureWith(recipe: recipe)
        cell.favRecipe = recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}

