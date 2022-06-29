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
    
    private var populars: [Dish] = [
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorit", calories: 111),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "22Some text about current dish", calories: 222),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "33Some text about current dish", calories: 333),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "44Some text about current dish", calories: 444),
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "55Some text about current dish", calories: 555),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "66Some text about current dish", calories: 777),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "77Some text about current dish", calories: 888),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "88Some text about current dish", calories: 999)
    ]
    
    private var specials: [Dish] = [
        .init(id: "id1", name: "Dish11", image: "https://source.unsplash.com/random/", description: "1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish", calories: 111),
        .init(id: "id2", name: "Dish22", image: "https://source.unsplash.com/random/", description: "2Some text about current dish", calories: 222),
        .init(id: "id3", name: "Dish33", image: "https://source.unsplash.com/random/", description: "3Some text about current dish", calories: 333),
        .init(id: "id4", name: "Dish44", image: "https://source.unsplash.com/random/", description: "4Some text about current dish", calories: 444),
        .init(id: "id1", name: "Dish55", image: "https://source.unsplash.com/random/", description: "5Some text about current dish", calories: 555),
        .init(id: "id2", name: "Dish66", image: "https://source.unsplash.com/random/", description: "6Some text about current dish", calories: 777),
        .init(id: "id3", name: "Dish77", image: "https://source.unsplash.com/random/", description: "7Some text about current dish", calories: 888),
        .init(id: "id4", name: "Dish88", image: "https://source.unsplash.com/random/", description: "8Some text about current dish", calories: 999)
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
        mainView.frame = view.bounds
    }
    
    // MARK: - Setups
    
    private func setAppWasLaunched() {
        UserDefaults.setAppWasLaunched()
    }
    
    private func setupVC() {
        title = "Food Delivery"
        navigationController?.navigationBar.tintColor = .appRed
        navigationItem.backButtonTitle = "Back"
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
        
        view.addSubview(mainView)
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
        navigationItem.rightBarButtonItem?.tintColor = .appRed
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == mainView.categoryCollectionView {
            let category = categories[indexPath.row]
            let vc = DishListViewController(category: category)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let dish = collectionView == mainView.popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            let vc = DishDetailViewController(dish: dish)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
