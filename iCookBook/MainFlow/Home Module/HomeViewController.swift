//
//  ViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 25.02.2023.
//

import UIKit

final class HomeViewController: UIViewController {

    var tableView: UITableView!

    var recipesArray = [Recipe]() {
        didSet {
            recipesArray.forEach { print($0.title)}
        }
    }

    let networkService = NetvorkService()

    private func getPopularRecipes() {
        networkService.getPopularRecipes { result in
            switch result {
            case .success(let spoonacularModel):
                DispatchQueue.main.async {
                    self.recipesArray = spoonacularModel.recipes
                    self.tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        getPopularRecipes()

        setupLayout()
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
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipesArray.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.cellId, for: indexPath) as! RecipeTableViewCell
        let recepie = recipesArray[indexPath.row]
        cell.configureWith(recipe: recepie)
        cell.textLabel?.text = recepie.title
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
}

