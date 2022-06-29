//
//  UILabel+Extensions.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import UIKit

extension UILabel {
    
    func addInterlineSpacing(spacing: CGFloat = 2) {
        guard let textString = text else { return }
        
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
                          ))
        
        attributedText = attributedString
    }
    
}

