//
//  ContactViewController.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/6/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - ContactViewController

class ContactViewController: UIViewController {
    
    // MARK: Properties

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var avatarView: UIImageView!

    var viewModel: ContactViewModel!
    
    var saveButtonPressed: (() -> Void)?
    var cancelButtonPressed: (() -> Void)?

    private var firstNameBinding: UITextFieldBinding!
    private var lastNameBinding: UITextFieldBinding!
    private var phoneNumberBinding: UITextFieldBinding!
    private var genderBinding: UISegmentedControlBinding<Contact.Gender>!

    // MARK: Actions

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        cancelButtonPressed?()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard viewModel.isValidContact() else {
            showOKAlert(title: "Forbidden!",
                        message: "You must supply a first and last name",
                        completion: nil)
            return
        }

        viewModel.save()
        saveButtonPressed?()
    }
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(dismissKeybaord))
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)

        firstNameBinding = UITextFieldBinding()
            .bind(firstNameTextField)
            .to(viewModel.firstName)
        lastNameBinding = UITextFieldBinding()
            .bind(lastNameTextField)
            .to(viewModel.lastName)
        phoneNumberBinding = UITextFieldBinding()
            .bind(phoneNumberTextField)
            .to(viewModel.phoneNumber)
        genderBinding = UISegmentedControlBinding()
            .bind(genderSegmentedControl)
            .to(viewModel.gender)
            .observe { [weak self] gender in
                if gender == .male {
                    self?.avatarView.image = .maleLarge
                } else {
                    self?.avatarView.image = .femaleLarge
                }
            }
    }
    
    // MARK: Private
    
    @objc private func dismissKeybaord() {
        view.endEditing(true)
    }
}
