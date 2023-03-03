//
//  DetailsViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import UIKit

class DetailsViewController: UIViewController {

    let titleLabel = UILabel()
    let steps = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

    init(recipe: Recipe) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
