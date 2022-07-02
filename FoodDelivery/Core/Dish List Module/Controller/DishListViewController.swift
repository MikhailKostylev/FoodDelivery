//
//  DishListViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit

final class DishListViewController: UIViewController {
    
    private var dishListView: DishListView!
    
    private var category: DishCategory?
    private var dishes: [Dish] = []
    
    // MARK: - Init
    
    init(category: DishCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupTableView()
        fetchCategoryDishes()
    }
    
    // MARK: - Setups
    
    private func setupVC() {
        view.backgroundColor = Constants.backgroundColor
        navigationItem.backButtonTitle = "Back"
        title = category?.name
    }
    
    private func setupTableView() {
        dishListView = DishListView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height
            )
        )
        
        view.addSubview(dishListView)
        dishListView?.tableView.delegate = self
        dishListView?.tableView.dataSource = self
    }
    
    // MARK: - Network
    
    private func fetchCategoryDishes() {
        dishListView.showSpinner()
        
        guard let categoryId = category?.id else { return }
        
        NetworkService.shared.fetchCategoryDishes(categoryId: categoryId) { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.dishListView.dismissSpinner()
                self?.dishes = dishes
                self?.dishListView.tableView.reloadData()
                
            case .failure(let error):
                self?.dishListView.showErrorAlert(error: error)
            }
        }
    }
}

// MARK: - TableView methods

extension DishListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DishListTableViewCell.id,
            for: indexPath) as! DishListTableViewCell
        cell.configure(model: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dish = dishes[indexPath.row]
        let vc = DishDetailViewController(dish: dish)
        navigationController?.pushViewController(vc, animated: true)
    }
}
