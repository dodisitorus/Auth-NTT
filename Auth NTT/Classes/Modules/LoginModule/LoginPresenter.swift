//
//  LoginPresenter.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//  
//

import Foundation

class LoginPresenter: ViewToPresenterLoginProtocol {
    // MARK: Properties
    var view: PresenterToViewLoginProtocol?
    var interactor: PresenterToInteractorLoginProtocol?
    var router: PresenterToRouterLoginProtocol?
    
    func loginEmail(_ email: String, password: String) {
        
        view?.showHUD()
        interactor?.requestLoginEmail(email, password: password)
    }
}

extension LoginPresenter: InteractorToPresenterLoginProtocol {
    func requestLoginSuccess(data: [String: Any]) {
        
        view?.hideHUD()
        
        interactor?.saveDataUser(data: data, completion: { (state) in
            
            self.router?.navigateToHome(on: self.view!)
            
        })
    }
    
    func requestLoginFailure(errorCode: Int, message: String) {
        
        view?.hideHUD()
    }
}
