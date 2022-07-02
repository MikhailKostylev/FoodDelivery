//
//  SceneDelegate.swift
//  FoodDelivery
//
//  Created by Mikhail Kostylev on 25.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        setupWindow(scene: scene)
    }
    
    // MARK: - Private Methods
    
    private func setupWindow(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootVC = chooseRootVC()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootVC
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
    
    private func chooseRootVC() -> UIViewController {
        if UserDefaults.standard.hasOnboarded {
            return UINavigationController(rootViewController: MainViewController())
        } else {
            return OnboardingViewController()
        }
    }
    
    // MARK: - Scene Lifecycle

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

