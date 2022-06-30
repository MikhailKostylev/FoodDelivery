//
//  APIResponse.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 30.06.2022.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
