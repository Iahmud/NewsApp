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
        vc.viewModel = HomeViewModel()
        pushViewController(vc)
    }

    func gotoFavourite() {
        let vc = HomeVC.instantiate()
        vc.coordinator = self
        vc.viewModel = FavouriteViewModel()
        pushViewController(vc)
    }
   
    func gotoDetais(_ article : ArticleModel) {
        let vc = DetailsVC.instantiate()
        vc.coordinator = self
        vc.viewModel.article = article
        pushViewController(vc)
    }
    
    func pushViewController(_ vc:UIViewController) {
        navigationController.pushViewController(vc, animated: animated)
    }
    
    func back() {
        navigationController.popViewController(animated: animated)
    }
    

}


//MARK: - Loading Delegate

public protocol LoadingDelegate: AnyObject {
    func showLoading(_ currentVC:UIViewController)
    func hideLoading()
}

public protocol MessageDelegate: AnyObject {
    func showToast(_ message:String , in currentVC:UIViewController)
}

extension MainCoordinator : LoadingDelegate {
    func showLoading(_ currentVC:UIViewController) {
        DispatchQueue.main.async {
            JustHUD.shared.showInView(view: currentVC.view)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            JustHUD.shared.hide()
        }
    }
 
}

//MARK: - Message Delegate


extension MainCoordinator :  MessageDelegate {
    
    func showToast(_ message:String , in currentVC:UIViewController) {
        DispatchQueue.main.async {
            currentVC.view.makeToast(message, duration: 3,  position: .bottom)
        }
    }
}
