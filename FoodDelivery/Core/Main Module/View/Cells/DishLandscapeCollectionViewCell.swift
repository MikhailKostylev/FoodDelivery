//
//  DishLandscapeCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 26.06.2022.
//

import UIKit
import Kingfisher
import SkeletonView

final class DishLandscapeCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: DishLandscapeCollectionViewCell.self)
    
    private let padding: CGFloat = 8
    private let imageSide: CGFloat = 64
    
    private lazy var view = CardView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .appRed
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .regular)
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
    
    func configure(model: Dish) {
        imageView.kf.setImage(with: model.image?.asUrl)
        titleLabel.text = model.name
        descriptionLabel.text = model.description
        caloriesLabel.text = model.formattedCalories
    }
    
    private func setupCell() {
        clipsToBounds = false
        isSkeletonable = true
    }
        
    private func setupLayout() {
        contentView.addSubview(view)
        view.addSubview(imageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(caloriesLabel)
        
        view.prepareForAutoLayout()
        stackView.prepareForAutoLayout()
        imageView.prepareForAutoLayout()
        titleLabel.prepareForAutoLayout()
        descriptionLabel.prepareForAutoLayout()
        caloriesLabel.prepareForAutoLayout()
        
        let constraints = [
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSide),
            imageView.heightAnchor.constraint(equalToConstant: imageSide),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding*2),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding*2),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
