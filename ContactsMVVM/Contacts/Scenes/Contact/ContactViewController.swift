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
    
    var contactUUID: String? {
        didSet {
            guard let contactUUID = contactUUID else { return }
            let realm = try! Realm()
            let contact = realm.object(
                ofType: Contact.self,
                forPrimaryKey: contactUUID
                )!
            
            firstName = contact.firstName
            lastName = contact.lastName
            phoneNumber = contact.phoneNumber
            gender = contact.gender
        }
    }
    
    private var firstName = ""
    private var lastName = ""
    private var phoneNumber = ""
    private var gender = Contact.Gender.male
    
    // MARK: Actions
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard isValidContact() else {
            showOKAlert(title: "Forbidden!",
                        message: "You must supply a first and last name",
                        completion: nil)
            return
        }
        
        let contact = Contact(
            uuid: contactUUID ?? UUID().uuidString,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            gender: gender
        )
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(contact, update: true)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstNameChanged(_ sender: UITextField) {
        firstName = sender.text ?? ""
    }
    
    @IBAction func lastNameChanged(_ sender: UITextField) {
        lastName = sender.text ?? ""
    }
    
    @IBAction func phoneNumberChanged(_ sender: UITextField) {
        phoneNumber = sender.text ?? ""
    }
    
    @IBAction func genderChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            avatarView.image = .maleLarge
            gender = .male
        } else {
            avatarView.image = .femaleLarge
            gender = .female
        }
    }
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapper = UITapGestureRecognizer(target: self, action:#selector(dismissKeybaord))
        tapper.cancelsTouchesInView = false
        view.addGestureRecognizer(tapper)
        
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        phoneNumberTextField.text = phoneNumber
        if gender == .male {
            genderSegmentedControl.selectedSegmentIndex = 0
            avatarView.image = .maleLarge
        } else {
            genderSegmentedControl.selectedSegmentIndex = 1
            avatarView.image = .femaleLarge
        }
    }
    
    // MARK: Private
    
    @objc private func dismissKeybaord() {
        view.endEditing(true)
    }
    
    private func isValidContact() -> Bool {
        return !firstName.isEmpty && !lastName.isEmpty
    }
}
