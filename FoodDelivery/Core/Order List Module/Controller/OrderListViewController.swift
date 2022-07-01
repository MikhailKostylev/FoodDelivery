//
//  OrderListViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit

class OrderListViewController: UIViewController {
    
    private var orderListView: OrderListView!
    
    private var orders: [Order] = [
        Order(id: "id1", name: "Dish1", dish: Dish(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorit", calories: 111)),
        Order(id: "id2", name: "Dish2", dish: Dish(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorit", calories: 222)),
        Order(id: "id3", name: "Dish3", dish: Dish(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorit", calories: 333)),
        Order(id: "id4", name: "Dish4", dish: Dish(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorit", calories: 444)),
        Order(id: "id5", name: "Dish5", dish: Dish(id: "id5", name: "Dish5", image: "https://source.unsplash.com/random/", description: "This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorit", calories: 555)),
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        orderListView.tableView.frame = view.bounds
    }
    
    // MARK: - Setups
    
    private func setupVC() {
        view.backgroundColor = Constants.backgroundColor
        navigationItem.backButtonTitle = "Back"
        title = "Orders"
    }
    
    private func setupTableView() {
        orderListView = OrderListView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height
            )
        )
        
        view.addSubview(orderListView)
        orderListView?.tableView.delegate = self
        orderListView?.tableView.dataSource = self
    }
}

// MARK: - TableView methods

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: OrderListTableViewCell.id,
            for: indexPath) as! OrderListTableViewCell
        cell.configure(model: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dish = orders[indexPath.row].dish else { return }
        let vc = DishDetailViewController(dish: dish)
        navigationController?.pushViewController(vc, animated: true)
    }
}
