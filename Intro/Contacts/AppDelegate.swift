//
//  AppDelegate.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/4/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        launchMVC()
//        launchMVVM()

        return true
    }
    
    func launchMVC() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contactViewController = storyboard.instantiateViewController(
            withIdentifier: "ContactViewControllerMVC") as! ContactViewControllerMVC
        contactViewController.contact = Contact(
            uuid: UUID().uuidString,
            firstName: "Jim",
            lastName: "Jones (MVC)",
            phoneNumber: "1234567890",
            gender: .male
        )
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = contactViewController
        self.window?.makeKeyAndVisible()
    }
    
    func launchMVVM() {
        
        let contactViewModel = ContactViewModel(contact: Contact(
            uuid: UUID().uuidString,
            firstName: "Jim",
            lastName: "Jones (MVVM)",
            phoneNumber: "1234567890",
            gender: .male
        ))
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contactViewController = storyboard.instantiateViewController(
            withIdentifier: "ContactViewControllerMVVM") as! ContactViewControllerMVVM
        contactViewController.viewModel = contactViewModel
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = contactViewController
        self.window?.makeKeyAndVisible()
    }
}

