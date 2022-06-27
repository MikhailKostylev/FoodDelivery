//
//  CategoryCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 26.06.2022.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: CategoryCollectionViewCell.self)
    
    private let padding: CGFloat = 8
    private let imageSide: CGFloat = 40
    
    private lazy var view = CardView()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Test Message"
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(category: DishCategory) {
        titleLabel.text = category.name
        imageView.kf.setImage(with: category.image?.asUrl)
    }
    
    private func setupCell() {
        self.clipsToBounds = false
    }
        
    private func setupLayout() {
        contentView.addSubview(view)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        
        view.prepareForAutoLayout()
        imageView.prepareForAutoLayout()
        titleLabel.prepareForAutoLayout()
        
        let constraints = [
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: imageSide),
            imageView.heightAnchor.constraint(equalToConstant: imageSide),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
