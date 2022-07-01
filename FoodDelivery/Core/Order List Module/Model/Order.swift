//
//  Order.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 29.06.2022.
//

import Foundation

struct Order: Codable {
    let id, name: String?
    let dish: Dish?
}
