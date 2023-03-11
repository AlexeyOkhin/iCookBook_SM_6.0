//
//  CategoryViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import UIKit


final class CategoryViewController: UIViewController {

    let cateogriesArray = CategoryModel.categoryModels

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CategoryCellView.self,
                       forCellReuseIdentifier: CategoryCellView.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        setupConstraints()
    }


    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateogriesArray.count
    }
    
    //MARK: FOR CREATING CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCellView.identifier,
                                                       for: indexPath) as! CategoryCellView
        let category = cateogriesArray[indexPath.row]

        cell.configure(with: category)
        
        
        return cell
    }
    
    //MARK: FOR CHANGING CELL HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //MARK: FOR SELECTING CELL HEIGHT
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = cateogriesArray[indexPath.row]

        let categoryVC = HomeViewController(category: category)

        navigationController?.pushViewController(categoryVC, animated: true)
    }
}
