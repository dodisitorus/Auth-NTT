//
//  LoginContract.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewLoginProtocol {
    func onRequestLoginSuccess()
    func onRequestLoginFailure(error: String)
    
    func showHUD()
    func hideHUD()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterLoginProtocol {
    
    var view: PresenterToViewLoginProtocol? { get set }
    var interactor: PresenterToInteractorLoginProtocol? { get set }
    var router: PresenterToRouterLoginProtocol? { get set }
    
    func loginEmail(_ username: String, password: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorLoginProtocol {
    
    var presenter: InteractorToPresenterLoginProtocol? { get set }
    
    func requestLoginEmail(_ email: String, password: String)
    
    func saveDataUser(data: [String: Any], completion: @escaping(Bool) -> ())
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterLoginProtocol {
    
    func requestLoginSuccess(data: [String: Any])
    func requestLoginFailure(errorCode: Int, message: String)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterLoginProtocol {
    
    func navigateToHome(on view: PresenterToViewLoginProtocol)
}
