//
//  UserDefaults+extensions.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 26.06.2022.
//

import Foundation

extension UserDefaults {
    
    private enum UserDefaultsKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultsKeys.hasOnboarded.rawValue)
        }
    }
}
