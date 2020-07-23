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
        
//        let json = """
//        {
//          "_meta": {
//            "count": 2
//          },
//          "items": [
//            {
//                  "id": 1,
//                    "name": "Материал один",
//                    "section": "Первая секция",
//              "date": "2020-02-17",
//              "files": {
//                        "doc": "1(0).docx",
//                "add": [
//                  "1(1).png"
//                ]
//              },
//              "keywords": [
//                "материал один",
//                "первая секция",
//                "материал",
//                "один",
//                "первая",
//                "секция",
//                "mat"
//              ],
//              "tests": [
//                {
//                            "question": "Вопрос один",
//                  "answer1": "Ответ один",
//                  "answer2": "Ответ два",
//                  "answer3": "Ответ три",
//                  "answer4": "Ответ четыре",
//                  "correct_answer": 1
//                },
//                        {
//                            "question": "Вопрос два",
//                  "answer1": "Ответ один",
//                  "answer2": "Ответ два",
//                  "answer3": "Ответ три",
//                  "answer4": "Ответ четыре",
//                  "correct_answer": 4
//                }
//              ]
//            },
//            {
//                    "id": 2,
//                    "name": "Материал два",
//              "section": "Секция два",
//              "date": "2020-02-17",
//              "files": {
//                        "doc": "2(0).docx",
//                "add": []
//              },
//              "keywords": [
//                "материал два",
//                "секция два",
//                "Материал",
//                "два",
//                "секция",
//                "два",
//                "mat"
//              ],
//              "tests": [
//                {
//                            "question": "Вопрос один",
//                  "answer1": "Ответ один",
//                  "answer2": "Ответ два",
//                  "answer3": "Ответ три",
//                  "answer4": "Ответ четыре",
//                  "correct_answer": 3
//                }
//              ]
//            }
//          ]
//        }
//        """
        
//        let data = json.data(using: .utf8)!
//
//        let a = try! JSONDecoder().decode(MaterialsResponse.self, from: data)
        
//        ApiManager.loadAllMaterials { materials in
//            dump(materials!)
//        }
        
        //dump(a)
        
        
        
        
        
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

