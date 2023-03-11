//
//  SearchCellView.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 01.03.2023.
//

import UIKit

final class SearchCellView: UITableViewCell {
    
    static let identifier = "SearchCellView"
    lazy var favoriteStorage = FavoriteStorage.shared
    var favRecipe: Recipe?
    
    lazy var foodTitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.numberOfLines = 0
        title.textColor = .black
        title.textAlignment = .left
        
        return title
    }()
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysTemplate),
                                  for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemOrange
        button.addTarget(nil, action: #selector(favTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(foodTitle)
        addSubview(foodImageView)
        backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        foodTitle.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.frame.size.width - 170,
                                 height: contentView.frame.size.height - 10)
        
        foodImageView.frame = CGRect(x: contentView.frame.size.width - 160,
                                     y: 5,
                                     width: 160,
                                     height: contentView.frame.size.height - 10)
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodTitle.text = nil
        foodImageView.image = nil
    }
    
}




// MARK: - ADDING METHODS

extension SearchCellView {
    
    func configureWith(recipe: Recipe) {
        
        foodTitle.text = recipe.title
        ImageLoader2.shared.fetchImage(for: recipe) { image, id, error in
            if let image {
                self.foodImageView.image = image
            }
        }
    }
    
    @objc private func favTapped(sender: UIButton) {
        guard let favoriteRecipe = favRecipe else { return }

        if favoriteStorage.contains(favoriteRecipe) {
            sender.tintColor = .white
            favoriteStorage.remove(favoriteRecipe)
        } else {
            favoriteStorage.add(favoriteRecipe)
            favRecipe?.isFaved = true
            sender.tintColor = .systemOrange
        }
    }
    
}
