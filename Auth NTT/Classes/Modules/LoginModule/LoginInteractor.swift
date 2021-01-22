//
//  LoginInteractor.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//  
//

import Foundation
import FirebaseAuth

class LoginInteractor: PresenterToInteractorLoginProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterLoginProtocol?
    
    func requestLoginEmail(_ email: String, password: String) {
     
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in

            if (error == nil) {
                
                let data: [String: Any] = [
                    "email": email,
                    "password": password,
                    "name": authResult?.user.displayName ?? "-"
                ]
                
                self.presenter?.requestLoginSuccess(data: data)
                
            } else {
                
                self.presenter?.requestLoginFailure(errorCode: 400, message: error?.localizedDescription ?? "-")
            }
        }
    }
    
    func saveDataUser(data: [String: Any], completion: @escaping(Bool) -> ()) {
        
        let email: String = data["email"] as? String ?? ""
        let name: String = data["name"] as? String ?? ""
        
        let statusLoginData = "true".data(using: .utf8)
        let nameData = name.data(using: .utf8)
        let emailData = email.data(using: .utf8)
        
        LocalStore.setMulti(keys: [keyStores.statusLogin, keyStores.fullname, keyStores.email], values: [statusLoginData!, nameData!, emailData!], completionHandler: { (result) in

            completion(true)
            
        })
    }
}
