//
//  AppDelegate.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        setupRootViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func setupRootViewController() {
        let navigationController = UINavigationController(rootViewController: MomentsViewController())
        self.window?.rootViewController = navigationController
    }
    
}

