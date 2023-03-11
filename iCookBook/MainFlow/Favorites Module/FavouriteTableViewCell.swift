//
//  FavouriteTableViewCell.swift
//  iCookBook
//
//  Created by Smolya on 06.03.2023.
//

import UIKit

final class FavouriteTableViewCell: UITableViewCell {
    
    static let favouriteCell = "favouriteCellView"
    lazy var favoriteStorage = FavoriteStorage.shared
    var favRecipe: Recipe?
    lazy var bottomGradientView = GradientView(from: .top, to: .bottom, startColor: .clear, endColor: .black)
    lazy var topGradientView = GradientView(from: .bottom, to: .top, startColor: .clear, endColor: .black)
    
    lazy var favouriteImageView: UIImageView = {
        let favouriteImage = UIImageView()
        favouriteImage.translatesAutoresizingMaskIntoConstraints = false
        favouriteImage.contentMode = .scaleAspectFill
        favouriteImage.layer.cornerRadius = 5
        favouriteImage.backgroundColor = .red
        favouriteImage.clipsToBounds = true
        return favouriteImage
    }()
    
    lazy var favouriteTitleLabel: UILabel = {
        let favouriteTitle = UILabel()
        favouriteTitle.text = "Salad"
        favouriteTitle.font = .preferredFont(forTextStyle: .headline)
        favouriteTitle.numberOfLines = 0
        favouriteTitle.textColor = .white
        favouriteTitle.translatesAutoresizingMaskIntoConstraints = false
        return favouriteTitle
    }()
    
    
    lazy var favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysTemplate),
                                  for: .normal)
        button.tintColor = .systemOrange
        button.addTarget(nil, action: #selector(favTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        clipsToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favouriteTitleLabel.text = nil
        favouriteImageView.image = nil
        favoritesButton.tintColor = .systemOrange
    }
    
}




// MARK: - ADDING METHODS

extension FavouriteTableViewCell {
    
    @objc private func favTapped() {
        guard let favoriteRecipe = favRecipe else { return }
        
        if favoriteStorage.contains(favoriteRecipe) {
            favoritesButton.tintColor = .white
            favRecipe?.isFaved = false
            favoriteStorage.remove(favoriteRecipe)
        } else {
            favoriteStorage.add(favoriteRecipe)
            favRecipe?.isFaved = true
            favoritesButton.tintColor = .systemOrange
        }
        
    }
    
    func configureWith(recipe: Recipe) {
        favouriteTitleLabel.text = recipe.title
        ImageLoader2.shared.fetchImage(for: recipe) { image, id, error in
            if let image {
                self.favouriteImageView.image = image
            }
        }
    }
    
    private func setupUI() {
        bottomGradientView.translatesAutoresizingMaskIntoConstraints = false
        topGradientView.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(favouriteImageView)
        addSubview(favouriteTitleLabel)
        addSubview(favoritesButton)
        favouriteImageView.addSubview(bottomGradientView)
        favouriteImageView.addSubview(topGradientView)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            bottomGradientView.heightAnchor.constraint(equalToConstant: 80),
            bottomGradientView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            bottomGradientView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            bottomGradientView.bottomAnchor.constraint(equalTo: favouriteImageView.bottomAnchor),
            
            
            favouriteImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            favouriteImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            favouriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            favouriteImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            
            topGradientView.heightAnchor.constraint(equalToConstant: 80),
            topGradientView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            topGradientView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            topGradientView.topAnchor.constraint(equalTo: favouriteImageView.topAnchor),
            
            favouriteTitleLabel.centerYAnchor.constraint(equalTo: topGradientView.centerYAnchor),
            favouriteTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            favouriteTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoritesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50),
            favoritesButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
