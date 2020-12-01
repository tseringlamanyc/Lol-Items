//
//  ImageCell.swift
//  Lol-Items
//
//  Created by Tsering Lama on 11/25/20.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "imageCell"
//
//    public lazy var imageView: UIImageView = {
//      let iv = UIImageView()
//      iv.image = UIImage(systemName: "photo")
//      iv.layer.cornerRadius = 8
//      iv.clipsToBounds = true
//      return iv
//    }()
//
//    override init(frame: CGRect) {
//      super.init(frame: frame)
//      commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//      super.init(coder: coder)
//      commonInit()
//    }
//
//    private func commonInit() {
//      imageViewConstraints()
//    }
//
//    private func imageViewConstraints() {
//      addSubview(imageView)
//      imageView.translatesAutoresizingMaskIntoConstraints = false
//      NSLayoutConstraint.activate([
//        imageView.topAnchor.constraint(equalTo: topAnchor),
//        imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//        imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
//        imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//      ])
//    }

    
    public lazy var textLabel: UILabel = {
      let label = UILabel()
      label.textAlignment = .center
        label.numberOfLines = 0 
      return label
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      commonInit()
    }
    
    private func commonInit() {
      textLabelConstraints()
    }
    
    private func textLabelConstraints() {
      addSubview(textLabel)
      textLabel.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
      ])
    }

}
