//
//  CategoryCellView.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 10.03.2023.
//

import UIKit

class CategoryCellView: UITableViewCell {
    
    static let identifier = "CategoryCellView"
    
    lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "AppIcon")
        
        return image
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hdsgshdfhdfhi"
        label.textColor = .red
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        categoryImage.addSubview(categoryLabel)
        addSubview(categoryImage)
        backgroundColor = .clear
        setupConstraint()
    }
    
    private func setupConstraint() {
        
        let padding = 8.0
        
        NSLayoutConstraint.activate([
            
            categoryImage.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoryImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            categoryImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            categoryLabel.trailingAnchor.constraint(equalTo: categoryImage.trailingAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: categoryImage.centerXAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
