//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var categories: [DishCategory] = [
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/"),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/"),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/"),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/"),
        .init(id: "id5", name: "Dish5", image: "https://source.unsplash.com/random/"),
        .init(id: "id6", name: "Dish6", image: "https://source.unsplash.com/random/"),
        .init(id: "id7", name: "Dish7", image: "https://source.unsplash.com/random/"),
        .init(id: "id8", name: "Dish8", image: "https://source.unsplash.com/random/"),
        .init(id: "id9", name: "Dish9", image: "https://source.unsplash.com/random/"),
    ]
    
    private var populars: [Dish] = [
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 111),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 222),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 333),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 444),
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 555),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 777),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 888),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 999)
    ]
    
    private let padding: CGFloat = 16
    private let sectionInset: CGFloat = 15
    private let collection1ViewHeightMultiplier: CGFloat = 0.25
    private let collection2ViewHeightMultiplier: CGFloat = 0.45
    private let collection3ViewHeightMultiplier: CGFloat = 0.25
    private let categoryCellHeightDivider: CGFloat = 3.7
    private let popularCellHeHeightDivider: CGFloat = 1.35
    private let categoryCellWidth: CGFloat = 150
    
    // MARK: - UI elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
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
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: categoryCellWidth, height: (view.height*collection1ViewHeightMultiplier)/categoryCellHeightDivider)
        layout.sectionInset = UIEdgeInsets(top: sectionInset/3, left: sectionInset, bottom: 0, right: sectionInset)
        layout.minimumLineSpacing = sectionInset
        layout.minimumInteritemSpacing = sectionInset/3
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.id
        )
        return collectionView
    }()
    
    private lazy var popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (view.width/2)-sectionInset, height: (view.height*collection2ViewHeightMultiplier)/popularCellHeHeightDivider)
        layout.sectionInset = UIEdgeInsets(top: sectionInset/3, left: sectionInset, bottom: 0, right: sectionInset)
        layout.minimumLineSpacing = sectionInset
        layout.minimumInteritemSpacing = sectionInset/3
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            DishBannerCollectionViewCell.self,
            forCellWithReuseIdentifier: DishBannerCollectionViewCell.id
        )
        return collectionView
    }()
    
    private lazy var specialCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.width, height: view.height*collection3ViewHeightMultiplier)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            ChefsSpecialsCollectionViewCell.self,
            forCellWithReuseIdentifier: ChefsSpecialsCollectionViewCell.id
        )
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppWasLaunched()
        setupVC()
        setupBarButton()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setAppWasLaunched() {
        UserDefaults.setAppWasLaunched()
    }
    
    private func setupVC() {
        view.backgroundColor = .systemBackground
        title = "Food Delivery"
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart.fill"),
            style: .done,
            target: self,
            action: #selector(didTapCartButton)
        )
    }
    
    // MARK: - Actions
    
    @objc private func didTapCartButton() {
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView: return categories.count
        case popularCollectionView: return populars.count
        case specialCollectionView: return categories.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCollectionViewCell.id,
                for: indexPath) as! CategoryCollectionViewCell
            cell.configure(category: categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DishBannerCollectionViewCell.id,
                for: indexPath) as! DishBannerCollectionViewCell
            cell.configure(dish: populars[indexPath.row])
            return cell
        case specialCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ChefsSpecialsCollectionViewCell.id,
                for: indexPath) as! ChefsSpecialsCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - Layout

extension MainViewController {
    
    private func setupLayout() {
        view.addSubview(scrollView)
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
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            foodCategoryView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            foodCategoryView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            foodCategoryView.topAnchor.constraint(equalTo: containerView.topAnchor),
            foodCategoryView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: collection1ViewHeightMultiplier),
            
            foodCategoryLabel.centerXAnchor.constraint(equalTo: foodCategoryView.centerXAnchor),
            foodCategoryLabel.widthAnchor.constraint(equalTo: foodCategoryView.widthAnchor, constant: -padding*2),
            foodCategoryLabel.topAnchor.constraint(equalTo: foodCategoryView.topAnchor, constant: padding),
            
            categoryCollectionView.centerXAnchor.constraint(equalTo: foodCategoryView.centerXAnchor),
            categoryCollectionView.widthAnchor.constraint(equalTo: foodCategoryView.widthAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: foodCategoryLabel.bottomAnchor, constant: padding/2),
            categoryCollectionView.bottomAnchor.constraint(equalTo: foodCategoryView.bottomAnchor),
            
            popularDishesView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            popularDishesView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            popularDishesView.topAnchor.constraint(equalTo: foodCategoryView.bottomAnchor),
            popularDishesView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: collection2ViewHeightMultiplier),
            
            popularDishesLabel.centerXAnchor.constraint(equalTo: popularDishesView.centerXAnchor),
            popularDishesLabel.widthAnchor.constraint(equalTo: popularDishesView.widthAnchor, constant: -padding*2),
            popularDishesLabel.topAnchor.constraint(equalTo: popularDishesView.topAnchor, constant: padding),
            
            popularCollectionView.centerXAnchor.constraint(equalTo: popularDishesView.centerXAnchor),
            popularCollectionView.widthAnchor.constraint(equalTo: popularDishesView.widthAnchor),
            popularCollectionView.topAnchor.constraint(equalTo: popularDishesLabel.bottomAnchor, constant: padding/2),
            popularCollectionView.bottomAnchor.constraint(equalTo: popularDishesView.bottomAnchor),
            
            chefsSpecialsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            chefsSpecialsView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            chefsSpecialsView.topAnchor.constraint(equalTo: popularDishesView.bottomAnchor),
            chefsSpecialsView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: collection3ViewHeightMultiplier),
            
            chefsSpecialsLabel.centerXAnchor.constraint(equalTo: chefsSpecialsView.centerXAnchor),
            chefsSpecialsLabel.widthAnchor.constraint(equalTo: chefsSpecialsView.widthAnchor, constant: -padding*2),
            chefsSpecialsLabel.topAnchor.constraint(equalTo: chefsSpecialsView.topAnchor, constant: padding),
            
            specialCollectionView.centerXAnchor.constraint(equalTo: chefsSpecialsView.centerXAnchor),
            specialCollectionView.widthAnchor.constraint(equalTo: chefsSpecialsView.widthAnchor),
            specialCollectionView.topAnchor.constraint(equalTo: chefsSpecialsLabel.bottomAnchor, constant: padding/2),
            specialCollectionView.bottomAnchor.constraint(equalTo: chefsSpecialsView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
