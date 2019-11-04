//
//  AppDelegate.swift
//  MyNews
//
//  Created by Svyat Chaplin on 02.11.2019.
//  Copyright © 2019 Svyat Chaplin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainScreenViewController = storyboard.instantiateViewController(identifier: "MainScreenVC") as? MainViewController,
            let favoriteViewController = storyboard.instantiateViewController(identifier: "FavoriteScreenVC") as? FavoriteTableViewController,
            let tabBarController = storyboard.instantiateViewController(identifier: "TabBarController") as? UITabBarController else {
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

