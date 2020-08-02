//
//  AppDelegate.swift
//  Materials
//
//  Created by art-off on 22.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        ApiManager.authUser(withEmail: "tema2707@icloud.com", password: "1234") { user in
//            guard let user = user else { return }
//            print(user)
//            DispatchQueue.main.async {
//                DataManager.shared.write(user: user)
//            }
//        }
        
//        ApiManager.loadAllMaterials { materials in
//            DispatchQueue.main.async {
//                guard let materials = materials else { return }
//                DataManager.shared.write(materials: materials)
//            }
//        }
        
        MaterialHelper.getLastMonthMaterials()
        MaterialHelper.getNotLastMonthMaterials()

        
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

