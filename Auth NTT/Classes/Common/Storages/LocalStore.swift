//
//  LocalStore.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//

import Foundation

class LocalStore: NSObject {
    
    var value: String?
    
    static func get(key: String, completionHandler: (String) -> ()) {
        let defaults = UserDefaults.standard
        let dataString = defaults.string(forKey: key)
        
        if dataString != nil {
            completionHandler(dataString!)
        } else {
            completionHandler("")
        }
    }
    
    static func set(key: String, value: Data, completionHandler: (LocalStore) -> ()) {
        let defaults = UserDefaults.standard
        let dataString = String(data: value, encoding: String.Encoding.utf8)
        defaults.set(dataString, forKey: key)
        let respone = LocalStore()
        respone.value = "success"
        
        completionHandler(respone)
    }
    
    static func getMulti(keys: [String], completionHandler: ([LocalStore]) -> ()) {
        let defaults = UserDefaults.standard
        
        
        var localStoreArray: [LocalStore] = []
        
        for i in 0..<keys.count {
            let localStore = LocalStore()
            let dataString = defaults.string(forKey: keys[i])
            
            localStore.value = dataString
            localStoreArray.append(localStore)
        }
        
        completionHandler(localStoreArray)
    }
    
    static func setMulti(keys: [String], values: [Data], completionHandler: (LocalStore) -> ()) {
        let defaults = UserDefaults.standard
        
        for i in 0..<keys.count {
            let dataString = String(data: values[i], encoding: String.Encoding.utf8)
            defaults.set(dataString, forKey: keys[i])
        }
        
        let respone = LocalStore()
        respone.value = "success"
        
        completionHandler(respone)
    }
    
    static func removeAll(completionHandler: (LocalStore) -> ()) {
         let defaults = UserDefaults.standard
        
         let domain = Bundle.main.bundleIdentifier!
         defaults.removePersistentDomain(forName: domain)
        
         let respone = LocalStore()
         respone.value = "success"
         
         completionHandler(respone)
     }
}
