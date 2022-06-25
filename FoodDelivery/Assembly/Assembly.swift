//
//  Assembly.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

final class Assembly {
    
    func configureMainModule() -> UIViewController {
        let mainVC = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        return navigationController
    }
}
