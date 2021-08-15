//
//  AppDelegate.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 13/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRoot()
        return true
    }
    
    func setRoot() {
        window = .init()
        window?.rootViewController = UINavigationController(rootViewController: PhotosListViewController())
        window?.makeKeyAndVisible()
    }

}

