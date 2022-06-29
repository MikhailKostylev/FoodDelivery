//
//  MainView.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 28.06.2022.
//

import UIKit

class MainView: UIView {
    
    private let padding: CGFloat = 16
    private let sectionInset: CGFloat = 15
    private let sideInset: CGFloat = 20
    private let infoGradientViewHeight: CGFloat = 44
    private let categoryCollectionViewHeightMultiplier: CGFloat = 0.25
    private let popularCollectionViewHeightMultiplier: CGFloat = 0.5
    private let specialCollectionViewHeightMultiplier: CGFloat = 0.2
    private let categoryCellHeightDivider: CGFloat = 3.7
    private let popularCellHeightDivider: CGFloat = 1.35
    private let specialCellHeightDivider: CGFloat = 1.7
    
    // MARK: - UI elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor
        return view
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .appYellow
        return view
    }()
    
    private lazy var foodCategoryView = UIView()
    private lazy var popularDishesView = UIView()
    private lazy var chefsSpecialsView = UIView()
    
    private lazy var foodCategoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Food Category"
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var popularDishesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Popular Dishes"
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var chefsSpecialsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Chef's Specials"
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width/2.75, height: (height*categoryCollectionViewHeightMultiplier)/categoryCellHeightDivider)
        layout.sectionInset = UIEdgeInsets(top: sectionInset/3, left: sideInset, bottom: 0, right: sideInset)
        layout.minimumLineSpacing = sectionInset
        layout.minimumInteritemSpacing = sectionInset/3
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.register(
            DishCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: DishCategoryCollectionViewCell.id
        )
        return collectionView
    }()
    
    lazy var popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (width/2)-sideInset, height:  (height*popularCollectionViewHeightMultiplier)/popularCellHeightDivider)
        layout.sectionInset = UIEdgeInsets(top: sectionInset/3, left: sideInset, bottom: 0, right: sideInset)
        layout.minimumLineSpacing = sectionInset
        layout.minimumInteritemSpacing = sectionInset/3
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.register(
            DishPortraitCollectionViewCell.self,
            forCellWithReuseIdentifier: DishPortraitCollectionViewCell.id
        )
        return collectionView
    }()
    
    lazy var specialCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width/1.5, height: (height*specialCollectionViewHeightMultiplier)/specialCellHeightDivider)
        layout.sectionInset = UIEdgeInsets(top: sectionInset/3, left: sideInset, bottom: 0, right: sideInset)
        layout.minimumLineSpacing = sectionInset
        layout.minimumInteritemSpacing = sectionInset/3
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.register(
            DishLandscapeCollectionViewCell.self,
            forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.id
        )
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(topView)
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(foodCategoryView)
        containerView.addSubview(popularDishesView)
        containerView.addSubview(chefsSpecialsView)
        foodCategoryView.addSubview(foodCategoryLabel)
        foodCategoryView.addSubview(categoryCollectionView)
        popularDishesView.addSubview(popularDishesLabel)
        popularDishesView.addSubview(popularCollectionView)
        chefsSpecialsView.addSubview(chefsSpecialsLabel)
        chefsSpecialsView.addSubview(specialCollectionView)
        
        topView.prepareForAutoLayout()
        scrollView.prepareForAutoLayout()
        containerView.prepareForAutoLayout()
        foodCategoryView.prepareForAutoLayout()
        popularDishesView.prepareForAutoLayout()
        chefsSpecialsView.prepareForAutoLayout()
        foodCategoryLabel.prepareForAutoLayout()
        popularDishesLabel.prepareForAutoLayout()
        chefsSpecialsLabel.prepareForAutoLayout()
        categoryCollectionView.prepareForAutoLayout()
        popularCollectionView.prepareForAutoLayout()
        specialCollectionView.prepareForAutoLayout()
        
        let constraints = [
            topView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topView.widthAnchor.constraint(equalTo: self.widthAnchor),
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            foodCategoryView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            foodCategoryView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            foodCategoryView.topAnchor.constraint(equalTo: containerView.topAnchor),
            foodCategoryView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: categoryCollectionViewHeightMultiplier),
            
            foodCategoryLabel.leadingAnchor.constraint(equalTo: foodCategoryView.leadingAnchor, constant: padding),
            foodCategoryLabel.trailingAnchor.constraint(equalTo: foodCategoryView.trailingAnchor, constant: -padding),
            foodCategoryLabel.topAnchor.constraint(equalTo: foodCategoryView.topAnchor, constant: padding),
            
            categoryCollectionView.centerXAnchor.constraint(equalTo: foodCategoryView.centerXAnchor),
            categoryCollectionView.widthAnchor.constraint(equalTo: foodCategoryView.widthAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: foodCategoryLabel.bottomAnchor, constant: padding/2),
            categoryCollectionView.bottomAnchor.constraint(equalTo: foodCategoryView.bottomAnchor),
            
            popularDishesView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            popularDishesView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            popularDishesView.topAnchor.constraint(equalTo: foodCategoryView.bottomAnchor),
            popularDishesView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: popularCollectionViewHeightMultiplier),
            
            popularDishesLabel.leadingAnchor.constraint(equalTo: popularDishesView.leadingAnchor, constant: padding),
            popularDishesLabel.trailingAnchor.constraint(equalTo: popularDishesView.trailingAnchor, constant: -padding),
            popularDishesLabel.topAnchor.constraint(equalTo: popularDishesView.topAnchor, constant: padding),
            
            popularCollectionView.centerXAnchor.constraint(equalTo: popularDishesView.centerXAnchor),
            popularCollectionView.widthAnchor.constraint(equalTo: popularDishesView.widthAnchor),
            popularCollectionView.topAnchor.constraint(equalTo: popularDishesLabel.bottomAnchor, constant: padding/2),
            popularCollectionView.bottomAnchor.constraint(equalTo: popularDishesView.bottomAnchor),
            
            chefsSpecialsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            chefsSpecialsView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            chefsSpecialsView.topAnchor.constraint(equalTo: popularDishesView.bottomAnchor),
            chefsSpecialsView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: specialCollectionViewHeightMultiplier),
            
            chefsSpecialsLabel.leadingAnchor.constraint(equalTo: chefsSpecialsView.leadingAnchor, constant: padding),
            chefsSpecialsLabel.trailingAnchor.constraint(equalTo: chefsSpecialsView.trailingAnchor, constant: -padding),
            chefsSpecialsLabel.topAnchor.constraint(equalTo: chefsSpecialsView.topAnchor, constant: padding),
            
            specialCollectionView.centerXAnchor.constraint(equalTo: chefsSpecialsView.centerXAnchor),
            specialCollectionView.widthAnchor.constraint(equalTo: chefsSpecialsView.widthAnchor),
            specialCollectionView.topAnchor.constraint(equalTo: chefsSpecialsLabel.bottomAnchor, constant: padding/2),
            specialCollectionView.bottomAnchor.constraint(equalTo: chefsSpecialsView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
