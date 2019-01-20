//
//  ContactCoordinator.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/9/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

class ContactCoordinator {
    
    private let contactUUID: String?
    private let presentingViewController: UIViewController
    
    var completion: (() -> Void)?
    
    init(contactUUID: String?, presentingViewController: UIViewController) {
        self.contactUUID = contactUUID
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Contact", bundle: nil)
        let navigationController = storyboard.instantiateViewController(
            withIdentifier: "ContactViewControllerNav") as! UINavigationController
        let contactViewController = navigationController.topViewController as! ContactViewController
        contactViewController.viewModel = ContactViewModel(contactUUID: contactUUID)
        contactViewController.saveButtonPressed = { [weak self] in
            self?.presentingViewController.dismiss(animated: true, completion: nil)
            self?.completion?()
        }
        contactViewController.cancelButtonPressed = { [weak self] in
            self?.presentingViewController.dismiss(animated: true, completion: nil)
            self?.completion?()
        }
        presentingViewController.present(navigationController, animated: true, completion: nil)
    }
}
