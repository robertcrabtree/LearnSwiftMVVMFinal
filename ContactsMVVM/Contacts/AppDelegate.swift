//
//  AppDelegate.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/4/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        seedRealmIfNeeded()
        
        appCoordinator = AppCoordinator(
            window: UIWindow(frame: UIScreen.main.bounds)
        )
        appCoordinator?.start()
        
        return true
    }
    
    private func seedRealmIfNeeded() {
        let realm = try! Realm()
        if realm.objects(Contact.self).count == 0 {
            try! realm.write {
                realm.add(Contact.seed(), update: false)
            }
        }
    }
}

