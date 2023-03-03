//
//  ResultsVC.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 01.03.2023.
//

import UIKit

class ResultsVC: UIViewController {
    
    let networkService = NetworkService()
    var requestFailed: Bool?
    
    var recipesArray = [Recipe]()
    var currentData = [Recipe]()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchCellView.self,
                       forCellReuseIdentifier: SearchCellView.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewUpdate()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPopularRecipes()
    }
    
}




// MARK: - ADDING METHODS
extension ResultsVC {
    
    private func viewUpdate() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    func filterCurrentDataSource(searchTerm: String) {
        if searchTerm.count > 0 {
            currentData = recipesArray
            
            let filteredResult = currentData.filter {
                $0.title.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
            }

            currentData = filteredResult
            tableView.reloadData()
        }
    }
    
    private func getPopularRecipes() {
        networkService.getPopularRecipes { [weak self] result in
            switch result {
            case .success(let spoonacularModel):
                DispatchQueue.main.async { [weak self] in
                    self?.recipesArray = spoonacularModel?.recipes ?? []
                    self?.tableView.reloadData()
                }
            case .failure:
                self?.requestFailed = true
            }
        }
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
    
    //MARK: FOR COUNTING CELL COUNT
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentData.count
    }
    
    //MARK: FOR CREATING CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCellView.identifier,
                                                       for: indexPath) as! SearchCellView
        
        let recepie = currentData[indexPath.row]
        cell.configureWith(recipe: recepie)
        
        return cell
    }
    
    //MARK: FOR CHANGING CELL HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    //MARK: FOR SELECTING CELL HEIGHT
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
