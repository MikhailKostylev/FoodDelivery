//
//  DishCategory.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 27.06.2022.
//

import Foundation

struct DishCategory: Codable {
    let id, name, image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
}
