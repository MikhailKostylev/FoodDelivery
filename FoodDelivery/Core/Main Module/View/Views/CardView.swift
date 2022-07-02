//
//  CardView.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 27.06.2022.
//

import UIKit

final class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = Constants.foregroundColor
        layer.shadowColor = Constants.shadow
        layer.shadowOffset = .zero
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
    }
}
