//
//  AppDelegate.swift
//  PryanikyTest
//
//  Created by Михаил Задорожный on 05.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = MainViewController()
        vc.viewModel = MainViewModel()
        let nc = UINavigationController(rootViewController: vc)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.makeKeyAndVisible()
        window.rootViewController = nc

        return true
    }
}

