//
//  UserDefaults+extensions.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 26.06.2022.
//

import Foundation

extension UserDefaults {
    
    static func setAppWasLaunched() {
        standard.set(true, forKey: "wasAppLaunched")
    }
    
    static func wasAppLaunched() -> Bool {
        return standard.bool(forKey: "wasAppLaunched")
    }
}
