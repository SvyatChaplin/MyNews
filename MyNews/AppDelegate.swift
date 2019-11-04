//
//  AppDelegate.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit
import CoreData

//@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainScreenViewController = storyboard.instantiateViewController(withIdentifier: "MainScreenVC") as? MainViewController,
            let favoriteViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteScreenVC") as? FavoriteTableViewController,
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else {
                return true
        }
        let networkingManager = NetworkingManagerService()
        let storageManager = StorageManagerService()
        let mainModel = MainModel(storageManager: storageManager, networkingManager: networkingManager)
        mainScreenViewController.mainModel = mainModel
        let favoriteModel = FavoriteModel(storageManager: storageManager)
        favoriteViewController.favoriteModel = favoriteModel
        
        tabBarController.viewControllers = [mainScreenViewController, favoriteViewController]
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}

