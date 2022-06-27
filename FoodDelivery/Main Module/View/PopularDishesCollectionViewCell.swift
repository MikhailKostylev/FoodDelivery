//
//  PopularDishesCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 26.06.2022.
//

import UIKit

class PopularDishesCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: PopularDishesCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .appOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with viewModel: String) {
        
    }
}
