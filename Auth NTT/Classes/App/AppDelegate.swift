//
//  AppDelegate.swift
//  Auth NTT
//
//  Created by Dodi Sitorus on 21/01/21.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationController = UINavigationController()
        
        LocalStore.get(key: keyStores.statusLogin) { (status) in
            
            window = UIWindow(frame: UIScreen.main.bounds)
            
            if status == "true" {
                
                let homeController = HomeRouter.createModule()
                
                navigationController.viewControllers = [homeController]
                
            } else {
                
                let loginController = LoginRouter.createModule()
                
                navigationController.viewControllers = [loginController]
            }
        }
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // Mark::: Firebase
        FirebaseApp.configure()
        
        return true
    }
}

