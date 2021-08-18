//
//  AppDelegate.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 13/08/2021.
//

import UIKit
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRoot()
        return true
    }
    
    func setRoot() {
        window = .init()
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
        let isReachable = reachabilityManager?.isReachable ?? false
        
        window?.rootViewController = UINavigationController(rootViewController: PhotosListViewController(dataSource: isReachable ? OnlineDataLoader() : OfflineDataLoader()))
        
        window?.makeKeyAndVisible()
    }

}

