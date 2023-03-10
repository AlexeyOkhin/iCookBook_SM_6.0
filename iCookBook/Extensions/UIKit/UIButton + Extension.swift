//
//  UIButton + Extension.swift
//
//
//  Created by Djinsolobzik on 06.02.2023.
//

import UIKit

extension UIButton {
    convenience init(title: String,
                    backgroundColor: UIColor,
                    titleColor: UIColor,
                    cornerRadius: CGFloat,
                    font: UIFont? = .systemFont(ofSize: 18)) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
    }
    
}
