//
//  Route.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 30.06.2022.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://fooddelivery.glitch.me"
    
    case temp
    
    var description: String {
        switch self {
        case .temp: return "/temp"
        }
    }
}
