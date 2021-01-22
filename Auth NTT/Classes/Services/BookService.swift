//
//  BookService.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//

import Foundation

class BookService {
    
    static let shared = { BookService() }()
    
    func loadBooks(success: @escaping ([[String: Any]], Int) -> (), failure: @escaping (Int) -> ()) {
        
        let urlString = Endpoints.GET_BEERS // Saya ubah ke beers karna tidak menemukan api untuk buku
        
        APIClient.shared.requestJsonArray(urlString: urlString, token: nil, method: "GET") { (respone, code) in
            
            success(respone, code)
            
        } failure: { (code) in
            

            failure(code)
        }

    }
}
