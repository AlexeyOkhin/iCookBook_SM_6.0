//
//  SearchViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var letsFindLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's find the tastiest recipe 🍕"
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var searchController = UISearchController(searchResultsController: ResultsVC())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewUpdate()
        setupConstraints()
        setupSearchController()
    }
    
}



// MARK: - ADDING METHODS
extension SearchViewController {
    
    // MARK: Updates for main view
    
    private func viewUpdate() {
        view.backgroundColor = .gray
        view.addSubview(letsFindLabel)
    }
    
    // MARK: Updates for search controller
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search recipes"
        searchController.searchBar.searchTextField.textColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "AppIcon"),
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    // MARK: Data Source Filtering
    private func filterDataSource(searchTerm: String) {
        
    }
    
    // MARK: Constraints update
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            letsFindLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letsFindLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}




// MARK: - UISearchController
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let vc = searchController.searchResultsController as? ResultsVC
        vc?.view.backgroundColor = .clear
        letsFindLabel.isHidden = true
        print(text)
    }
    
}




// MARK: UISearchControllerDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        letsFindLabel.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        letsFindLabel.isHidden = false
    }
    
}
