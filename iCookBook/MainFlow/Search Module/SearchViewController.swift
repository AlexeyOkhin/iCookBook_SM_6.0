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
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.numberOfLines = 0
        label.textAlignment = .center
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
        view.backgroundColor = .white
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
    
    // MARK: Constraints update
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            letsFindLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letsFindLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            letsFindLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            letsFindLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
}




// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        guard let vc = searchController.searchResultsController as? ResultsVC else { return }
        vc.view.backgroundColor = .clear
        vc.filterCurrentDataSource(searchTerm: text)
        letsFindLabel.isHidden = true
        
        if searchController.isActive && vc.currentData.isEmpty {
            letsFindLabel.isHidden = false
            letsFindLabel.text = "We don't have the recipes you're looking for. \n Try looking for another 🔎"
        } else if !searchController.isActive {
            letsFindLabel.isHidden = false
            letsFindLabel.text = "Let's find the tastiest recipe 🍕"
            return
        }
        
    }
    
}




// MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    private func searchBahrSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        guard let vc = searchController.searchResultsController as? ResultsVC else { return }
        vc.view.backgroundColor = .clear
        vc.filterCurrentDataSource(searchTerm: text)
        
    }
    
}
