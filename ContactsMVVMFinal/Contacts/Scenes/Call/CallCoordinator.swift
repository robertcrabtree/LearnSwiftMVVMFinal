//
//  CallCoordinator.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/9/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

class CallCoordinator {
    
    private let contactUUID: String
    private let presentingViewController: UIViewController
    
    var callDidEnd: (() -> Void)?

    init(contactUUID: String, presentingViewController: UIViewController) {
        self.contactUUID = contactUUID
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Call", bundle: nil)
        let callViewController = storyboard.instantiateViewController(
            withIdentifier: "CallViewController") as! CallViewController
        callViewController.modalPresentationStyle = .custom
        callViewController.modalTransitionStyle = .crossDissolve
        callViewController.viewModel = CallViewModel(contactUUID: contactUUID)
        callViewController.callDidEnd = { [weak self] in
            self?.presentingViewController.dismiss(animated: true, completion: nil)
            self?.callDidEnd?()
        }
        presentingViewController.present(callViewController, animated: true, completion: nil)
    }
}
