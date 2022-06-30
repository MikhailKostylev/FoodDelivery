//
//  DishListViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit

class DishListViewController: UIViewController {
    
    private var dishListView: DishListView!
    
    private var category: DishCategory?
    private var dishes: [Dish] = [
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorite dish1This is my favorit", calories: 111),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "22Some text about current dish", calories: 222),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "33Some text about current dish", calories: 333),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "44Some text about current dish", calories: 444),
        .init(id: "id1", name: "Dish1", image: "https://source.unsplash.com/random/", description: "55Some text about current dish", calories: 555),
        .init(id: "id2", name: "Dish2", image: "https://source.unsplash.com/random/", description: "66Some text about current dish", calories: 777),
        .init(id: "id3", name: "Dish3", image: "https://source.unsplash.com/random/", description: "77Some text about current dish", calories: 888),
        .init(id: "id4", name: "Dish4", image: "https://source.unsplash.com/random/", description: "88Some text about current dish", calories: 999)
    ]
    
    init(category: DishCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dishListView.tableView.frame = view.bounds
    }
    
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
}

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
