

import UIKit

class FavoritesViewController: UIViewController {
    
    lazy var favoritesStorage = FavoriteStorage.shared
    
    private lazy var centerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Here is not recipe"
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView ()
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.favouriteCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(centerLabel)
        
        setupConstraints()
        configureNavigationTitle()
        favoritesStorage.decode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        showLabel()
    }
    
}




// MARK: - ADDING METHODS
extension FavoritesViewController {
    
    private func configureNavigationTitle() {
        title = "Favorites"
    }
    
    private func showLabel() {
        
        if favoritesStorage.recipes.isEmpty {
            centerLabel.isHidden = false
        } else {
            centerLabel.isHidden = true
        }
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            centerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}



// MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.configure(recipe: favoritesStorage.recipes[indexPath.row])
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesStorage.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.favouriteCell,
                                                       for: indexPath) as? FavouriteTableViewCell else {
            return UITableViewCell()
        }
        
        let favorites = favoritesStorage.recipes
        cell.configureWith(recipe: favorites[indexPath.row])
        cell.favRecipe = favorites[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}


