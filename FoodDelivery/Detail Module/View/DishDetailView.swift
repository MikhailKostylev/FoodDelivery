//
//  DishDetailView.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 28.06.2022.
//

import UIKit

class DishDetailView: UIView {
    
    private let padding: CGFloat = 16
    private let caloriesLabelWidth: CGFloat = 100
    private let nameTextFieldHeight: CGFloat = 50
    private let placeOrderButtonHeight: CGFloat = 50
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = padding
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var caloriesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .appRed
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .words
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.keyboardType = .default
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.layer.masksToBounds = true
        field.placeholder = "Enter your name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let placeOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Place Order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .appRed
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ssetupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ssetupLayout()
    }
    
    private func ssetupLayout() {
        addSubview(imageView)
        addSubview(vStackView)
        vStackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(titleLabel)
        hStackView.addArrangedSubview(caloriesLabel)
        vStackView.addArrangedSubview(descriptionLabel)
        vStackView.addArrangedSubview(nameTextField)
        vStackView.addArrangedSubview(placeOrderButton)
        
        imageView.prepareForAutoLayout()
        vStackView.prepareForAutoLayout()
        hStackView.prepareForAutoLayout()
        titleLabel.prepareForAutoLayout()
        caloriesLabel.prepareForAutoLayout()
        descriptionLabel.prepareForAutoLayout()
        nameTextField.prepareForAutoLayout()
        placeOrderButton.prepareForAutoLayout()
        
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            vStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            vStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
                        
            caloriesLabel.widthAnchor.constraint(equalToConstant: caloriesLabelWidth),
            
            nameTextField.heightAnchor.constraint(equalToConstant: nameTextFieldHeight),
            
            placeOrderButton.heightAnchor.constraint(equalToConstant: placeOrderButtonHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}