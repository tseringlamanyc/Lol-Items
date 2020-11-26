//
//  ViewController.swift
//  Lol-Items
//
//  Created by Tsering Lama on 11/24/20.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    enum Sections: Int {
        case primary
    }
    
    let apiClient = APIClient()
    
    private var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, Items>
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        loadItems()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemRed
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
    
    private func loadItems() {
        apiClient.fetchItems { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                DispatchQueue.main.async {
                    self?.updateSnapshot(item: items)
                }
            }
        }
    }
    
    private func updateSnapshot(item: Items) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([item], toSection: .primary)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard Sections(rawValue: sectionIndex) != nil else {
                fatalError()
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let itemSpacing: CGFloat = 5
            item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)
            
            let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitem: item, count: 1)
            
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(40))
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [innerGroup])
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            return section
        }
        return layout
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else {
                fatalError()
            }
            cell.imageView.kf.setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/10.24.1/img/item/\(item.image.full).png"))
            cell.imageView.contentMode = .scaleAspectFill
            cell.backgroundColor = .systemBlue
            return cell
        })
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
