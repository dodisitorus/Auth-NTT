//
//  HomeInteractor.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//  
//

import Foundation
import UIKit
import FirebaseAuth

class HomeInteractor: PresenterToInteractorHomeProtocol {

    // MARK: Properties
    var presenter: InteractorToPresenterHomeProtocol?
    var books: [Book]?
    
    func loadBooks() {
        
        BookService.shared.loadBooks { (dataBooks, code) in
            
            var list: [Book] = []
            
            for i in 0..<dataBooks.count {
                
                let id: String = dataBooks[i]["id"] as? String ?? "";
                let name: String = dataBooks[i]["name"] as? String ?? "";
                let desc: String = dataBooks[i]["description"] as? String ?? "";
                    
                list.append(Book(id: id, name: name, desc: desc))
            }
            
            self.books = list
            
            self.presenter?.requestBooskSuccess(data: list)
            
        } failure: { (errCode) in
            
            self.presenter?.requestBooksFailure(errorCode: errCode)
        }
    }
    
    func logout() {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let falseStatus = "false".data(using: .utf8)
        
        LocalStore.setMulti(keys: [keyStores.statusLogin], values: [falseStatus!]) { (reponse) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.presenter?.onLogoutSuccess()
            }
        }
    }
}
