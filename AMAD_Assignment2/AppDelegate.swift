//
//  AppDelegate.swift
//  AMAD_Assignment2
//
//  Created by Pranalee Jadhav on 9/10/18.
//  Copyright © 2018 Pranalee Jadhav. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(showHomeScreen(_:)), name: Notification.Name("com.mad.showhomescreen"), object: nil)
        
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func showHomeScreen(_ notification:Notification){
        
        //change status bar appearance
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.init(red:0.14, green:0.32, blue:0.85, alpha:1)
        }
        
        let userid = UserDefaults.standard.string(forKey: "token")
        //check user is logged in or not
        if userid != nil {
            //user is logged in, redirect to home page
            let bundle = Bundle.main
            let storyboard = UIStoryboard(name: "Main", bundle: bundle)
            
            let viewController: HomeScreenViewController = storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
            
        } else {
            //user is not logged in, redirect to login page
            
            let bundle = Bundle.main
            let storyboard = UIStoryboard(name: "Main", bundle: bundle)
            
            let loginViewController: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = loginViewController
            self.window?.makeKeyAndVisible()
        }
        
    }


}

