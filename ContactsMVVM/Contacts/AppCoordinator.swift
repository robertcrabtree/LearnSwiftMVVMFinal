//
//  AppCoordinator.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/9/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    let window: UIWindow
    
    var contactsCoordinator: ContactsCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        contactsCoordinator = ContactsCoordinator(window: window)
        contactsCoordinator?.start()
    }
}
