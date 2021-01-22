//
//  LoginService.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//

import Foundation

class AuthService {
    
    static let shared = { AuthService() }()
    
    func loginWithEmail(username: String, password: String, success: @escaping ([String: Any], Int) -> (), failure: @escaping (Int) -> ()) {
        
        let urlString = Endpoints.LOGIN
        
        APIClient.shared.requestWithFormData(urlString: urlString, username: username, password: password, token: nil, success: { (data, code) in
            
            success(data, code)
            
        }) { (code) in
            
            failure(code)
        }
    }
}
