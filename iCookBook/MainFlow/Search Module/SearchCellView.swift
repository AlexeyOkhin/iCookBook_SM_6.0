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
        title.text = "Hello"
        
        return title
    }()
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(foodTitle)
        contentView.addSubview(foodImageView)
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        foodTitle.text = nil
        foodImageView.image = nil
    }
    
    func configure(with viewModel: SearchCellView) {
        
    }
        
    
}
