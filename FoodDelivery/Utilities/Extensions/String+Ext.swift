//
//  String+Extension.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 27.06.2022.
//

import UIKit

extension String {
    
    var asUrl: URL? {
        return URL(string: self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
