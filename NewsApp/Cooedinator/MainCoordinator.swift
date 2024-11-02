//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private let animated = true
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: true)

    }
    
    func start() {
        navigationController.delegate = self
        let vc = HomeVC.instantiate()
        vc.coordinator = self
        pushViewController(vc)
    }

   
    func pushViewController(_ vc:UIViewController) {
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func back() {
        navigationController.popViewController(animated: animated)
    }
    

}
