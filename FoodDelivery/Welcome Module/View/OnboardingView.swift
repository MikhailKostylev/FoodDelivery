//
//  OnboardingView.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 28.06.2022.
//

import UIKit

class OnboardingView: UIView {
    
    private let collectionHeightMultiplier: CGFloat = 0.8
    private let buttonHeight: CGFloat = 50
    private let buttonWidth: CGFloat = 150
    private let padding: CGFloat = 20
    private let cornerRadius: CGFloat = 30
    private let buttonCornerRadius: CGFloat = 15
    
    // MARK: - UI elements
    
    var collectionView: UICollectionView!
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appYellow
        view.layer.cornerRadius = cornerRadius
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = padding
        return stackView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isEnabled = false
        pageControl.currentPageIndicatorTintColor = .appRed
        pageControl.pageIndicatorTintColor = .appOrange
        return pageControl
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.backgroundColor = .appRed
        button.layer.cornerRadius = buttonCornerRadius
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("skip", for: .normal)
        button.setTitleColor(.appRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
        setupLayout()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.width, height: self.height * collectionHeightMultiplier)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(
            OnboardingSlideCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingSlideCollectionViewCell.identifier
        )
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        addSubview(containerView)
        addSubview(stackView)
        addSubview(skipButton)
        stackView.addArrangedSubview(pageControl)
        stackView.addArrangedSubview(nextButton)
        
        collectionView.prepareForAutoLayout()
        containerView.prepareForAutoLayout()
        stackView.prepareForAutoLayout()
        pageControl.prepareForAutoLayout()
        nextButton.prepareForAutoLayout()
        skipButton.prepareForAutoLayout()
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: collectionHeightMultiplier),
            
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            containerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: cornerRadius),
            
            stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            nextButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            nextButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            skipButton.topAnchor.constraint(equalTo: nextButton.topAnchor),
            skipButton.leadingAnchor.constraint(equalTo: nextButton.trailingAnchor),
            skipButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            skipButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
