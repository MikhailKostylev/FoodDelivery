//
//  OrderListViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit

class OrderListViewController: UIViewController {
    
    private var orderListView: OrderListView!
    
    private var orders: [Order] = []
    
    private var vcIsLoaded = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupTableView()
        showSpinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchOrders()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        orderListView.tableView.frame = view.bounds
    }
    
    deinit {
        orderListView.dismissSpinner()
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
    
    private func showSpinner() {
        orderListView.showSpinner()
    }
    
    // MARK: - Network
    
    private func fetchOrders() {
        NetworkService.shared.fetchOrders { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let orders):
                if self.vcIsLoaded {
                    self.orderListView.dismissSpinner()
                    self.orders = orders
                    self.orderListView.tableView.reloadData()
                } else {
                    self.orderListView.dismissSpinner()
                    self.orders = orders
                    self.orderListView.tableView.animateTableView()
                    self.vcIsLoaded = true
                }
                
            case .failure(let error):
                self.orderListView.showErrorAlert(error: error)
            }
        }
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
