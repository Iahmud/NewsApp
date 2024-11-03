//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?
    weak var screen : UIView? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.backgroundColor = AppTheme.shared.screenBackgroundColor
        return true
    }
    
}

