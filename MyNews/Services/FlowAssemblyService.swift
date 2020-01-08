//
//  FlowAssemblyService.swift
//  MyNews
//
//  Created by Svyat Chaplin on 08.01.2020.
//  Copyright © 2020 Svyat Chaplin. All rights reserved.
//

import Foundation
import UIKit

class FlowAssemblyService {

    static func setupFlow(_ window: UIWindow?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard
            let mainScreenViewController = storyboard.instantiateViewController(withIdentifier: "MainScreenVC") as? MainViewController,
            let favoriteViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteScreenVC") as? FavoriteTableViewController,
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController,
            let mainNavigationController = storyboard.instantiateViewController(withIdentifier: "MainNC") as? UINavigationController,
            let favoriteNavigationController = storyboard.instantiateViewController(withIdentifier: "FavoriteNC") as? UINavigationController else {
                return
        }

        let networkingManager = NetworkingManagerService()
        let storageManager = StorageManagerService()
        let mainModel = MainModel(storageManager: storageManager, networkingManager: networkingManager)
        mainScreenViewController.mainModel = mainModel
        let favoriteModel = FavoriteModel(storageManager: storageManager)
        favoriteViewController.favoriteModel = favoriteModel
        mainNavigationController.viewControllers = [mainScreenViewController]
        favoriteNavigationController.viewControllers = [favoriteViewController]
         tabBarController.viewControllers = [mainNavigationController, favoriteNavigationController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}
