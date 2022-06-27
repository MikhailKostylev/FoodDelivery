//
//  DishBannerCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 26.06.2022.
//

import UIKit
import Kingfisher

class DishBannerCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: DishBannerCollectionViewCell.self)
    
    private let padding: CGFloat = 8
    private let imageSide: CGFloat = 40
    
    private lazy var view = CardView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
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
        label.numberOfLines = 0
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
    
    func configure(dish: Dish) {
        titleLabel.text = dish.name
        imageView.kf.setImage(with: dish.image?.asUrl)
        caloriesLabel.text = dish.formattedCalories
        descriptionLabel.text = dish.description
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
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -padding*2),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -padding*2)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
