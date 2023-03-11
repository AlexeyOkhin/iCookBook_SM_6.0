//
//  DetailsTableViewCell.swift
//  iCookBook
//
//  Created by Нахид Гаджалиев on 10.03.2023.
//

import UIKit

final class DetailsTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    var recipe: Recipe?
    
    lazy var ingridientsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "рыба"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ingridientsNameLabel)
        contentView.addSubview(amountLabel)
        isUserInteractionEnabled = false
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




extension DetailsTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            ingridientsNameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            ingridientsNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            amountLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -5),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
    
    func configure(object: ExtendedIngredient) {
        ingridientsNameLabel.text = object.name.capitalized
        amountLabel.text = String(format: "%g", object.amount) + " \(object.unit)"
    }
    
}
