//
//  OrderListTableViewCell.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit
import Kingfisher

class OrderListTableViewCell: UITableViewCell {

    static let id = String(describing: OrderListTableViewCell.self)
    
    private let cornerRadius: CGFloat = 10
    private let padding: CGFloat = 16
    private let imageSide: CGFloat = 64
    
    private lazy var view = CardView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
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
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    private func setupCell() {
        clipsToBounds = false
        selectionStyle = .none
        contentView.backgroundColor = Constants.backgroundColor
    }
    
    func configure(model: Order) {
        dishImageView.kf.setImage(with: model.dish?.image?.asUrl)
        titleLabel.text = model.dish?.name
        descriptionLabel.text = model.name
    }
        
    private func setupLayout() {
        contentView.addSubview(view)
        view.addSubview(dishImageView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        view.prepareForAutoLayout()
        stackView.prepareForAutoLayout()
        dishImageView.prepareForAutoLayout()
        titleLabel.prepareForAutoLayout()
        descriptionLabel.prepareForAutoLayout()
        
        let constraints = [
            view.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            view.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            view.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            view.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            
            dishImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            dishImageView.widthAnchor.constraint(equalToConstant: imageSide),
            dishImageView.heightAnchor.constraint(equalToConstant: imageSide),
            dishImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: dishImageView.heightAnchor),
            stackView.leadingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
