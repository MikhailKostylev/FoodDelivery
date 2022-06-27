//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var categories: [FoodCategory] = [
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
    
    private let padding: CGFloat = 16
    private let sectionInset: CGFloat = 15
    private let collection1ViewHeightMultiplier: CGFloat = 0.25
    private let collection2ViewHeightMultiplier: CGFloat = 0.45
    private let collection3ViewHeightMultiplier: CGFloat = 0.25
    private let foodCategoryCellHeightDivider: CGFloat = 3.7
    private let foodCategoryCellWidth: CGFloat = 150
    
    // MARK: - UI elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var foodCategoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var popularDishesView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var chefsSpecialsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
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
    
    private lazy var collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: sectionInset/3, left: sectionInset, bottom: 0, right: sectionInset)
        layout.itemSize = CGSize(width: foodCategoryCellWidth, height: (view.height*collection1ViewHeightMultiplier)/foodCategoryCellHeightDivider)
        layout.minimumLineSpacing = sectionInset
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            FoodCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: FoodCategoryCollectionViewCell.id
        )
        return collectionView
    }()
    
    private lazy var collectionView2: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.width, height: view.height*collection2ViewHeightMultiplier)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            PopularDishesCollectionViewCell.self,
            forCellWithReuseIdentifier: PopularDishesCollectionViewCell.id
        )
        return collectionView
    }()
    
    private lazy var collectionView3: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.width, height: view.height*collection3ViewHeightMultiplier)
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
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collectionView1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FoodCategoryCollectionViewCell.id,
                for: indexPath) as! FoodCategoryCollectionViewCell
            cell.configure(category: categories[indexPath.row])
            return cell
        case collectionView2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularDishesCollectionViewCell.id,
                for: indexPath) as! PopularDishesCollectionViewCell
            return cell
        case collectionView3:
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
        foodCategoryView.addSubview(collectionView1)
        popularDishesView.addSubview(popularDishesLabel)
        popularDishesView.addSubview(collectionView2)
        chefsSpecialsView.addSubview(chefsSpecialsLabel)
        chefsSpecialsView.addSubview(collectionView3)
        
        scrollView.prepareForAutoLayout()
        containerView.prepareForAutoLayout()
        foodCategoryView.prepareForAutoLayout()
        popularDishesView.prepareForAutoLayout()
        chefsSpecialsView.prepareForAutoLayout()
        foodCategoryLabel.prepareForAutoLayout()
        popularDishesLabel.prepareForAutoLayout()
        chefsSpecialsLabel.prepareForAutoLayout()
        collectionView1.prepareForAutoLayout()
        collectionView2.prepareForAutoLayout()
        collectionView3.prepareForAutoLayout()
        
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
            
            collectionView1.centerXAnchor.constraint(equalTo: foodCategoryView.centerXAnchor),
            collectionView1.widthAnchor.constraint(equalTo: foodCategoryView.widthAnchor),
            collectionView1.topAnchor.constraint(equalTo: foodCategoryLabel.bottomAnchor, constant: padding/2),
            collectionView1.bottomAnchor.constraint(equalTo: foodCategoryView.bottomAnchor),
            
            popularDishesView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            popularDishesView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            popularDishesView.topAnchor.constraint(equalTo: foodCategoryView.bottomAnchor),
            popularDishesView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: collection2ViewHeightMultiplier),
            
            popularDishesLabel.centerXAnchor.constraint(equalTo: popularDishesView.centerXAnchor),
            popularDishesLabel.widthAnchor.constraint(equalTo: popularDishesView.widthAnchor, constant: -padding*2),
            popularDishesLabel.topAnchor.constraint(equalTo: popularDishesView.topAnchor, constant: padding),
            
            collectionView2.centerXAnchor.constraint(equalTo: popularDishesView.centerXAnchor),
            collectionView2.widthAnchor.constraint(equalTo: popularDishesView.widthAnchor),
            collectionView2.topAnchor.constraint(equalTo: popularDishesLabel.bottomAnchor, constant: padding/2),
            collectionView2.bottomAnchor.constraint(equalTo: popularDishesView.bottomAnchor),
            
            chefsSpecialsView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            chefsSpecialsView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            chefsSpecialsView.topAnchor.constraint(equalTo: popularDishesView.bottomAnchor),
            chefsSpecialsView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: collection3ViewHeightMultiplier),
            
            chefsSpecialsLabel.centerXAnchor.constraint(equalTo: chefsSpecialsView.centerXAnchor),
            chefsSpecialsLabel.widthAnchor.constraint(equalTo: chefsSpecialsView.widthAnchor, constant: -padding*2),
            chefsSpecialsLabel.topAnchor.constraint(equalTo: chefsSpecialsView.topAnchor, constant: padding),
            
            collectionView3.centerXAnchor.constraint(equalTo: chefsSpecialsView.centerXAnchor),
            collectionView3.widthAnchor.constraint(equalTo: chefsSpecialsView.widthAnchor),
            collectionView3.topAnchor.constraint(equalTo: chefsSpecialsLabel.bottomAnchor, constant: padding/2),
            collectionView3.bottomAnchor.constraint(equalTo: chefsSpecialsView.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
