//
//  CategoryCellView.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 10.03.2023.
//

import UIKit

final class CategoryCellView: UITableViewCell {
    
    static let identifier = "CategoryCellView"
    
    lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "AppIcon")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        categoryImage.addSubview(categoryLabel)
        contentView.addSubview(categoryImage)
        contentView.layer.cornerRadius = 18
        contentView.clipsToBounds = true
        backgroundColor = .clear
        setupConstraint()
    }
    
    private func setupConstraint() {
        
        let padding = 8.0
        
        NSLayoutConstraint.activate([
            
            categoryImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            categoryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            categoryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            categoryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            categoryLabel.trailingAnchor.constraint(equalTo: categoryImage.trailingAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: categoryImage.centerXAnchor),
            
        ])
    }

    func configure(with category: CategoryModel) {
        self.categoryImage.image = category.image
        self.categoryLabel.text = category.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
