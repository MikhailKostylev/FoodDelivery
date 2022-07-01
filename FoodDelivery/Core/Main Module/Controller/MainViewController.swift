//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit
import SkeletonView

class MainViewController: UIViewController {
    
    private var mainView: MainView!
    
    private var categories: [DishCategory] = []
    private var populars: [Dish] = []
    private var specials: [Dish] = []
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupMainView()
        setupBarButton()
        showSkeletonCells()
        fetchAllCategories()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.frame = view.bounds
    }
    
    // MARK: - Setups
    
    private func setupVC() {
        view.backgroundColor = Constants.backgroundColor
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
    
    private func showSkeletonCells() {
        mainView.categoryCollectionView.isSkeletonable = true
        mainView.popularCollectionView.isSkeletonable = true
        mainView.specialCollectionView.isSkeletonable = true
        
        mainView.categoryCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .secondarySystemBackground, secondaryColor: .systemBackground), animation: nil, transition: .crossDissolve(1))
        mainView.popularCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .secondarySystemBackground, secondaryColor: .systemBackground), animation: nil, transition: .crossDissolve(1))
        mainView.specialCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .secondarySystemBackground, secondaryColor: .systemBackground), animation: nil, transition: .crossDissolve(1))
    }
    
    // MARK: - Network
    
    private func fetchAllCategories() {
        mainView.showSpinner()
        
        NetworkService.shared.fetchAllCategories { [weak self] result in
            guard let self = self else { return }
                        
            switch result {
            case .success(let allDishes):
                self.mainView.dismissSpinner()
                
                self.categories = allDishes.categories ?? []
                self.populars = allDishes.populars ?? []
                self.specials = allDishes.specials ?? []
                
                self.mainView.categoryCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                self.mainView.popularCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                self.mainView.specialCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.2))
                
            case .failure(let error):
                self.mainView.showErrorAlert(error: error)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapCartButton() {
        let vc = OrderListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Collection's methods

extension MainViewController: UICollectionViewDelegate, SkeletonCollectionViewDataSource {
    
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
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch skeletonView {
        case mainView.categoryCollectionView: return DishCategoryCollectionViewCell.id
        case mainView.popularCollectionView: return DishPortraitCollectionViewCell.id
        case mainView.specialCollectionView: return DishLandscapeCollectionViewCell.id
        default:
            return ""
        }
    }
}
