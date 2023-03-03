//
//  SearchCellView.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 01.03.2023.
//

import UIKit

class SearchCellView: UITableViewCell {
    
    static let identifier = "SearchCellView"
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodTitle.text = nil
        foodImageView.image = nil
    }
    
    func configureWith(recipe: Recipe) {
        foodTitle.text = recipe.title
        ImageLoader2.shared.fetchImage(for: recipe) { image, id, error in
            if let image {
                self.foodImageView.image = image
            }
        }
    }
}
