//
//  Coordinator.swift
//  NewsApp
//
//  Created by Islam Ahmed on 03/11/2024.
//

import UIKit

protocol Coordinator : AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
    
}
