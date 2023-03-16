//
//  CategoryViewController.swift
//  iCookBook
//
//  Created by Djinsolobzik on 26.02.2023.
//

import UIKit

enum Section: Int, CaseIterable {
    case main
}

final class CategoryViewController: UIViewController {

    let cateogriesArray = CategoryModel.categoryModels

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, CategoryModel>?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupCollectionView()
        createDataSource()
        reloadData()
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)


        collectionView.register(CategoryCellView.self, forCellWithReuseIdentifier: CategoryCellView.identifier)

        collectionView.delegate = self
    }

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else { fatalError("Unknown section kind") }
            switch section {
            case .main: return self.createCategoryLayout()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config

        return layout
    }

    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CategoryModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cateogriesArray, toSection: .main)

        dataSource?.apply(snapshot, animatingDifferences: true)

    }

    private func createCategoryLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(120))
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 16, leading: 10, bottom: 0, trailing: 10)


        return section
    }


}

extension CategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        let categoryVC = HomeViewController(category: category)
        navigationController?.pushViewController(categoryVC, animated: true)

    }
}

extension CategoryViewController {

    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CategoryModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, category in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            switch section {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellView.identifier, for: indexPath) as! CategoryCellView
                cell.configure(with: category)
                return cell
            }
        })
    }
}
