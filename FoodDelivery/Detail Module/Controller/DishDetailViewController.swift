//
//  DishDetailViewController.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 28.06.2022.
//

import UIKit
import Kingfisher

class DishDetailViewController: UIViewController {
    
    var dish: Dish?
    var dishDetailView: DishDetailView!
    
    private let interlineSpacing: CGFloat = 10

    init(dish: Dish) {
        self.dish = dish
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupDishDetailView()
        addEdgeGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dishDetailView.showBackView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dishDetailView.frame = view.bounds
    }
    
    // MARK: - Setups
    
    private func setupVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupDishDetailView() {
        dishDetailView = DishDetailView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: view.height
            )
        )
                
        view.addSubview(dishDetailView)
        dishDetailView.imageView.kf.setImage(with: dish?.image?.asUrl)
        dishDetailView.titleLabel.text = dish?.name
        dishDetailView.descriptionLabel.text = dish?.description
        dishDetailView.descriptionLabel.addInterlineSpacing(spacing: interlineSpacing)
        dishDetailView.caloriesLabel.text = dish?.formattedCalories
    }
    
    private func addEdgeGestureRecognizer() {
        navigationController?.interactivePopGestureRecognizer?.addTarget(
            self,
            action: #selector(handlePopGesture(gesture:))
        )
    }
    
    @objc private func handlePopGesture(gesture: UIGestureRecognizer){
        if gesture.state == .changed {
            dishDetailView.hideBackView()
        } else {
            dishDetailView.showBackView()
        }
    }
    
    
}
