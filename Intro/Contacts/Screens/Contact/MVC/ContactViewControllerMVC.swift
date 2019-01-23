//
//  ContactViewControllerMVC.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/6/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

// MARK: - ContactViewControllerMVC

class ContactViewControllerMVC: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var avatarView: UIImageView!

    var contact: Contact!
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        phoneNumberTextField.text = contact.phoneNumber
        avatarView.image = contact.gender == .male ? .maleLarge : .femaleLarge
    }
}
