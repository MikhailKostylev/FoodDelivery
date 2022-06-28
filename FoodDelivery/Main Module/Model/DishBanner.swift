//
//  DishBanner.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 27.06.2022.
//

import Foundation

struct DishPortrait {
    let id, name, image, description: String?
    let calories: Int?
    
    var formattedCalories: String{
        return "\(calories ?? 0) calories"
    }
}
