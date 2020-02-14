//
//  AppDelegate.swift
//  IAPDemo
//
//  Created by rakesh.e.mishra on 14/01/20.
//  Copyright © 2020 Accenture. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpAppLevelAppearance()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
}

extension AppDelegate {
    /**
     Sets up any appearance changes that appears throughout the app
     */
    func setUpAppLevelAppearance() {
        setUpNavigationBarAppearance()
    }

    /**
     Sets up navigation bar appearance for title color, size and navigation bar color
     */
    func setUpNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = UIColor.white
        guard let font = UIFont.IAPDemo.navigationBarTitle else { return }
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: UIColor.IAPDemo.r17g17b17]
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}
