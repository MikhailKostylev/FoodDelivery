//
//  String+Extension.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 27.06.2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
