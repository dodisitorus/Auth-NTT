//
//  LoginRouter.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//  
//

import Foundation
import UIKit

class LoginRouter: PresenterToRouterLoginProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> LoginViewController {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let presenter: ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = LoginRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = LoginInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func navigateToHome(on view: PresenterToViewLoginProtocol) {
        
        let homeViewController = HomeRouter.createModule()
        
        let navigationController = UINavigationController()
        
        navigationController.viewControllers = [homeViewController]
        
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
}
