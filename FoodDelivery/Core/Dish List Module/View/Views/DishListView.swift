//
//  DishListView.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit

class DishListView: UIView {
    
    private let tableCellHeight: CGFloat = 114
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .appYellow
        return view
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.backgroundColor
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupLayout()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.rowHeight = tableCellHeight
        tableView.register(
            DishListTableViewCell.self,
            forCellReuseIdentifier: DishListTableViewCell.id
        )
    }
    
    private func setupLayout() {
        addSubview(tableView)
        addSubview(topView)
        
        tableView.prepareForAutoLayout()
        topView.prepareForAutoLayout()
        
        let constraints = [
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
