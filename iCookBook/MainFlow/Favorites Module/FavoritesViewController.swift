//
//  FavoritesViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
//    let identifire = "MyCell"
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configurateTableView()
        setupLaout()
    }
    
    private func configurateTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
    }
    
    private func setupLaout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //favoriteRecipesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        cell.textLabel?.text = " "

//        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.cellid, for: indexPath) a! RecipeTableViewCell
//        let recipe = recipeArray(indexPath.row)
//        cell.configureWith(recipe: recipe)
//        cell.textLabel?.text = recipe.title
//        return cell ?? uitablecellview()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 //размемр ячейки
    }
}



