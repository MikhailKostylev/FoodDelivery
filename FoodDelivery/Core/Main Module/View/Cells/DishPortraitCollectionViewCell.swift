//
//  DishPortraitCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 26.06.2022.
//

import UIKit
import Kingfisher

class DishPortraitCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: DishPortraitCollectionViewCell.self)
    
    private let padding: CGFloat = 8
    private let imageSide: CGFloat = 40
    
    private lazy var view = CardView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = padding
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
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
    
    private lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .appRed
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
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
    
    func configure(model: Dish) {
        titleLabel.text = model.name
        imageView.kf.setImage(with: model.image?.asUrl)
        caloriesLabel.text = model.formattedCalories
        descriptionLabel.text = model.description
    }
    
    private func setupCell() {
        self.clipsToBounds = false
    }
        
    private func setupLayout() {
        contentView.addSubview(view)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(caloriesLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        view.prepareForAutoLayout()
        stackView.prepareForAutoLayout()
        titleLabel.prepareForAutoLayout()
        imageView.prepareForAutoLayout()
        caloriesLabel.prepareForAutoLayout()
        descriptionLabel.prepareForAutoLayout()
        
        let constraints = [
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            view.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
