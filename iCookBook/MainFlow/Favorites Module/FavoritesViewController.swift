

import UIKit

class FavoritesViewController: UIViewController{
 
    private let tableView: UITableView = {
        let tableView = UITableView ()
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: FavouriteTableViewCell.favouriteCell)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        }
    }
    extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.favouriteCell,
                                                     for: indexPath)
            
            return cell
         }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 290
        }
    }

    
