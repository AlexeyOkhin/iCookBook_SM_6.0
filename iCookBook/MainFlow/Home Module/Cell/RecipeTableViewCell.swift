//
//  RecipeTableViewCell.swift
//  iCookBook
//
//  Created by Aleksey Kosov on 28.02.2023.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    lazy var favoriteStorage = FavoriteStorage.shared
    var favRecipe: Recipe?
    
    static let cellId = "recipeCell"
    
    lazy var recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.backgroundColor = .clear
        iv.image = UIImage(named: "placeholder")
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Картошка"
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Готовить 5 - 10 минут"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoritesButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysTemplate),
                                  for: .normal)
        button.addTarget(nil, action: #selector(favTapped(sender:)), for: .touchUpInside)
        
        switch favRecipe?.isFaved {
        case true:
            button.tintColor = .orange
        default:
            button.tintColor = .white
        }
        
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
    
    lazy var bottomGradientView = GradientView(from: .top, to: .bottom, startColor: .clear, endColor: .black)
    lazy var topGradientView = GradientView(from: .bottom, to: .top, startColor: .clear, endColor: .black)
    
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
    
    private func setupUI() {
        bottomGradientView.translatesAutoresizingMaskIntoConstraints = false
        topGradientView.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(recipeImageView)
        addSubview(secondaryLabel)
        addSubview(titleLabel)
        addSubview(favoritesButton)
        recipeImageView.addSubview(bottomGradientView)
        recipeImageView.addSubview(topGradientView)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            bottomGradientView.heightAnchor.constraint(equalToConstant: 80),
            bottomGradientView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            bottomGradientView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            bottomGradientView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            
            secondaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            secondaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            secondaryLabel.centerYAnchor.constraint(equalTo: bottomGradientView.centerYAnchor),
            
            recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            
            topGradientView.heightAnchor.constraint(equalToConstant: 80),
            topGradientView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            topGradientView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            topGradientView.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: topGradientView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            favoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoritesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50),
            favoritesButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        recipeImageView.image = nil
        secondaryLabel.text = nil
        favoritesButton.tintColor = .white
    }
    
    func configureWith(recipe: Recipe) {
        titleLabel.text = recipe.title
        let secondarytext = "\(recipe.extendedIngredients.count) ингредиентов | \(recipe.readyInMinutes) минут"
        secondaryLabel.text = secondarytext
        
        ImageLoader.shared.fetchImage(for: recipe) { image, id, error in
            if let image {
                self.recipeImageView.image = image
            }
        }
    }
    
}
