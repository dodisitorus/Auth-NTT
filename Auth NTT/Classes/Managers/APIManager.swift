//
//  APIManager.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//

import Foundation

class APIManager {
    
    static let shared = { APIManager() }()
    
    lazy var baseURL: String = {
        return "https://api.punkapi.com/v2/"
    }()
}


