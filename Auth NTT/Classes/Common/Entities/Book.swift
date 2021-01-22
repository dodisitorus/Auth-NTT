//
//  Book.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 22/01/21.
//

import Foundation

class Book: NSObject {
    
    var id: String
    var name: String
    var desc: String
    
    internal init(id: String, name: String, desc: String) {
        self.id = id
        self.name = name
        self.desc = desc
    }
}
