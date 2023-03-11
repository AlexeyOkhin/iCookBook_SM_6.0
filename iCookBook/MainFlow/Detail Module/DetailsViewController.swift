//
//  DetailsViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private var ingredients = [ExtendedIngredient]()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var сoloriesLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "40 Min"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var middlelabelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [сoloriesLabel, timerLabel])
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLayout()
        setConstraints()
    }
    
    func configure(recipe: Recipe) {
        
        foodNameLabel.text = recipe.title
        сoloriesLabel.text = "\(recipe.pricePerServing) colories"
        timerLabel.text = "Preparing in \(recipe.readyInMinutes) minutes"
        ingredients = recipe.extendedIngredients
        
        ImageLoader.shared.fetchImage(for: recipe) { image, id, error in
            if let image {
                self.foodImage.image = image
            }
        }
        
    }
    
    private func setLayout() {
        view.addSubview(foodNameLabel)
        view.addSubview(foodImage)
        view.addSubview(middlelabelStackView)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            foodNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            foodNameLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            foodNameLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            foodImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            foodImage.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 20),
            foodImage.heightAnchor.constraint(equalToConstant: 225),
            
            middlelabelStackView.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 20),
            middlelabelStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            middlelabelStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: middlelabelStackView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ]) }
}




// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier,
                                                 for: indexPath) as! DetailsTableViewCell
        cell.ingridientsNameLabel.text = "privet"
        cell.configure(object: ingredients[indexPath.row])
        return cell
    }
    
}
