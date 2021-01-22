//
//  HomeRouter.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//  
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    // MARK: Static methods
    static func createModule() -> HomeViewController {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = HomeRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = HomeInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func navigateDetail(navigationConroller navigationController:UINavigationController) {
        
        let detailViewController = DetailRouter.createModule()
        
        navigationController.pushViewController(detailViewController,animated: true)
    }
    
    func backToLogin() {
        
        let loginViewController = LoginRouter.createModule()
        
        let navigationController = UINavigationController()
        
        navigationController.viewControllers = [loginViewController]
        
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
}
