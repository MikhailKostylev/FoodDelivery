//
//  DishDetailView.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 28.06.2022.
//

import UIKit
import ProgressHUD

protocol DishDetailViewProtocol: AnyObject {
    func didTapPlaceOrderButton(name: String)
}

class DishDetailView: UIView {
    
    weak var delegate: DishDetailViewProtocol?
            
    private let padding: CGFloat = 16
    private let cornerRadius: CGFloat = 10
    private let backViewHeight: CGFloat = 44
    private let backViewWidth: CGFloat = 75
    private let caloriesLabelWidth: CGFloat = 100
    private let nameTextFieldHeight: CGFloat = 50
    private let placeOrderButtonHeight: CGFloat = 50
    private let descriptionLabelHeight: CGFloat = 50
    
    // MARK: - UI elements
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .appYellow.withAlphaComponent(0)
        view.layer.cornerRadius = backViewHeight/2
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
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
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 10
        label.textColor = .label.withAlphaComponent(0.7)
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
        field.layer.cornerRadius = cornerRadius
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.systemGray.cgColor
        field.layer.masksToBounds = true
        field.placeholder = "Enter your name"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private lazy var placeOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Place Order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .appRed
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Public methods
    
    func showErrorAlert(error: Error) {
        ProgressHUD.showError(error.localizedDescription)
    }
    
    func showBackView() {
        UIView.animate(withDuration: 0.5) {
            self.backView.backgroundColor = .appYellow.withAlphaComponent(1)
        }
    }
    
    func hideBackView() {
        UIView.animate(withDuration: 0.3) {
            self.backView.backgroundColor = .appYellow.withAlphaComponent(0)
        }
    }
    
    // MARK: - Private methods
    
    private func setup() {
        setupTextFieldDelefate()
        addAction()
        setupLayout()
    }
    
    private func setupTextFieldDelefate() {
        nameTextField.delegate = self
    }
    
    private func addAction() {
        placeOrderButton.addTarget(
            self,
            action: #selector(didTapPlaceOrderButton),
            for: .touchUpInside
        )
    }
    
    @objc private func didTapPlaceOrderButton() {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty else {
            ProgressHUD.showError("Please enter your name.")
            return
        }
        
        ProgressHUD.show("Placing Order...")
        delegate?.didTapPlaceOrderButton(name: name)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        backgroundColor = Constants.backgroundColor
        addSubview(imageView)
        addSubview(backView)
        addSubview(vStackView)
        vStackView.addArrangedSubview(hStackView)
        hStackView.addArrangedSubview(titleLabel)
        hStackView.addArrangedSubview(caloriesLabel)
        vStackView.addArrangedSubview(descriptionLabel)
        vStackView.addArrangedSubview(nameTextField)
        vStackView.addArrangedSubview(placeOrderButton)

        imageView.prepareForAutoLayout()
        backView.prepareForAutoLayout()
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
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -padding/3),
            
            backView.widthAnchor.constraint(equalToConstant: backViewWidth),
            backView.heightAnchor.constraint(equalToConstant: backViewHeight),
            backView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: padding/3),
            
            vStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            vStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            vStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            vStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
                                    
            caloriesLabel.widthAnchor.constraint(equalToConstant: caloriesLabelWidth),
            
            nameTextField.heightAnchor.constraint(equalToConstant: nameTextFieldHeight),
            
            placeOrderButton.heightAnchor.constraint(equalToConstant: placeOrderButtonHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - TextField Delegate

extension DishDetailView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            didTapPlaceOrderButton()
        }
        return true
    }
}
