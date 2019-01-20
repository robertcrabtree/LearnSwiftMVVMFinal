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

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        seedRealmIfNeeded()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(
            withIdentifier: "ContactsViewControllerNav") as! UINavigationController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
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

