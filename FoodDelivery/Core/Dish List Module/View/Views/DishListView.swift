//
//  DishListView.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit
import ProgressHUD

final class DishListView: UIView {
    
    private let tableCellHeight: CGFloat = 114
    
    // MARK: - UI elements
    
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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func showSpinner() {
        ProgressHUD.show()
    }
    
    func dismissSpinner() {
        ProgressHUD.dismiss()
    }
    
    func showErrorAlert(error: Error) {
        ProgressHUD.showError(error.localizedDescription)
    }
    
    // MARK: - Private methods
    
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
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(tableView)
        addSubview(topView)
        
        tableView.prepareForAutoLayout()
        topView.prepareForAutoLayout()
        
        let constraints = [
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
