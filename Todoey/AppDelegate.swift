//
//  AppDelegate.swift
//  Todoey
//
//  Created by Tarik M on 9/2/19.
//  Copyright © 2019 Tarik M. All rights reserved.
//

import UIKit
import RealmSwift





@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        //print(Realm.Configuration.defaultConfiguration.fileURL)
       
        
        do {
            _ = try Realm()
            }
         catch  {
            print("error : \(error)")
        }
        return true
    }

  



}

