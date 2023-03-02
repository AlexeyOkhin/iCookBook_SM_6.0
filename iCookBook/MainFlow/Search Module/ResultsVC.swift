//
//  ResultsVC.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 01.03.2023.
//

import UIKit

class ResultsVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchCellView.self,
                       forCellReuseIdentifier: SearchCellView.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    var recipeArray = ["10", "11", "12", "13", "daf", "10", "11", "12", "13", "daf"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewUpdate()
        setupConstraints()
    }
    
}




// MARK: - ADDING METHODS
extension ResultsVC {
    
    private func viewUpdate() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
}




// MARK: - UITableViewDelegate, UITableViewDataSource
extension ResultsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCellView.identifier,
                                                       for: indexPath) as? SearchCellView else { fatalError() }
        
        //cell.configure(with: recipeArray[indexPath.row])
        return cell
    }
 
}
