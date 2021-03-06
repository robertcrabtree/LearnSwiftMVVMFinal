//
//  ContactsCoordinator.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/9/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

class ContactsCoordinator {
    
    private let window: UIWindow
    
    private var contactCoordinator: ContactCoordinator?
    private var callCoordinator: CallCoordinator?
    private var contactsViewController: ContactsViewController?

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Contacts", bundle: nil)
        let navigationController = storyboard.instantiateViewController(
            withIdentifier: "ContactsViewControllerNav") as! UINavigationController
        let contactsViewController = navigationController.topViewController as! ContactsViewController
        
        contactsViewController.viewModel = ContactsViewModel()
        
        contactsViewController.addButtonPressed = { [weak self] in
            self?.launchContactViewController()
        }
        contactsViewController.callButtonPressed = { [weak self] contactUUID in
            self?.launchCallViewController(withContactUUID: contactUUID)
        }
        contactsViewController.contactSelected = { [weak self] contactUUID in
            self?.launchContactViewController(withContactUUID: contactUUID)
        }
        
        self.contactsViewController = contactsViewController

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func launchContactViewController(withContactUUID uuid: String? = nil) {
        guard let contactsViewController = contactsViewController else { return }

        contactCoordinator = ContactCoordinator(
            contactUUID: uuid,
            presentingViewController: contactsViewController
        )
        contactCoordinator?.completion = { [weak self] in
            self?.contactCoordinator = nil // release resources
        }
        contactCoordinator?.start()
    }
    
    private func launchCallViewController(withContactUUID uuid: String) {
        guard let contactsViewController = contactsViewController else { return }
        
        callCoordinator = CallCoordinator(
            contactUUID: uuid,
            presentingViewController: contactsViewController
        )
        callCoordinator?.callDidEnd = { [weak self] in
            self?.callCoordinator = nil // release resources
        }
        callCoordinator?.start()
    }
}
