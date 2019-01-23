//
//  ContactViewControllerMVVM.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/6/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

// MARK: - ContactViewControllerMVVM

class ContactViewControllerMVVM: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var avatarView: UIImageView!

    var viewModel: ContactViewModel!
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.text = viewModel.firstName
        lastNameTextField.text = viewModel.lastName
        phoneNumberTextField.text = viewModel.phoneNumber
        avatarView.image = viewModel.gender == .male ? .maleLarge : .femaleLarge
    }
}
