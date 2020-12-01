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
        loadItems()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
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
                    print(items)
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
        
    }
    
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else {
                fatalError()
            }
            cell.textLabel.text = item.name
            
//            cell.imageView.kf.setImage(with: URL(string: "https://ddragon.leagueoflegends.com/cdn/10.24.1/img/item/\(item.image.full).png"))
            cell.backgroundColor = .systemBlue
            return cell
        })
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.primary])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
