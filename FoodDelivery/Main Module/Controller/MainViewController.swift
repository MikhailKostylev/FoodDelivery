//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainView: MainView!
    
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
    
    private var populars: [DishPortrait] = [
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 111),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 222),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 333),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 444),
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 555),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 777),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 888),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 999)
    ]
    
    private var specials: [DishLandscape] = [
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "Tkis is my favorite dish", calories: 111),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 222),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 333),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 444),
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 555),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 777),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 888),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "Some text about current dish", calories: 999)
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppWasLaunched()
        setupVC()
        setupMainView()
        setupBarButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    
    private func setupLayout() {
        view.addSubview(mainView)
        mainView.frame = view.bounds
    }
    
    private func setupMainView() {
        mainView = MainView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height
            )
        )
        
        mainView.categoryCollectionView.delegate = self
        mainView.popularCollectionView.delegate = self
        mainView.specialCollectionView.delegate = self
        mainView.categoryCollectionView.dataSource = self
        mainView.popularCollectionView.dataSource = self
        mainView.specialCollectionView.dataSource = self
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "cart.fill"),
            style: .done,
            target: self,
            action: #selector(didTapCartButton)
        )
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    // MARK: - Actions
    
    @objc private func didTapCartButton() {
        
    }
}

// MARK: - Collection's Methods

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainView.categoryCollectionView: return categories.count
        case mainView.popularCollectionView: return populars.count
        case mainView.specialCollectionView: return specials.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DishCategoryCollectionViewCell.id,
                for: indexPath) as! DishCategoryCollectionViewCell
            cell.configure(model: categories[indexPath.row])
            return cell
        case mainView.popularCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DishPortraitCollectionViewCell.id,
                for: indexPath) as! DishPortraitCollectionViewCell
            cell.configure(model: populars[indexPath.row])
            return cell
        case mainView.specialCollectionView:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DishLandscapeCollectionViewCell.id,
                for: indexPath) as! DishLandscapeCollectionViewCell
            cell.configure(model: specials[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
