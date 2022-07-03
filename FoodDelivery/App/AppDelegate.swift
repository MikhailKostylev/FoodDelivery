//
//  AppDelegate.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavBar()
        setupIQKeyboard()
        
        return true
    }
    
    // MARK: - Private methods
    
    private func setupNavBar() {
        UINavigationBar.appearance().titleTextAttributes = configureNavBarTitle()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .label
    }
    
    private func configureNavBarTitle() -> [NSAttributedString.Key: NSObject] {
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize(width: 1, height: 1)
        myShadow.shadowColor = UIColor.label.withAlphaComponent(0.7)
        
        return [
            NSAttributedString.Key.foregroundColor: UIColor.secondarySystemBackground,
            NSAttributedString.Key.font: UIFont(name: "Futura-Bold", size: 22)!,
            NSAttributedString.Key.shadow: myShadow
        ]
    }
    
    private func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

