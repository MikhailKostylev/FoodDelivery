//
//  DishLandscape.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 28.06.2022.
//

import Foundation

struct DishLandscape {
    let id, name, image, description: String?
    let calories: Int?
    
    var formattedCalories: String{
        return "\(calories ?? 0) calories"
    }
}
