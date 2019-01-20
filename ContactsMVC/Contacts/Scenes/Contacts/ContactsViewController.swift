//
//  ContactsViewController.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/4/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - ContactsViewController

class ContactsViewController: UITableViewController {

    // MARK: Properties

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sortByLastSwitch: UISwitch!
    
    var contacts: Results<Contact>!
    var contactsToken: NotificationToken!

    // MARK: Actions

    @IBAction func addButtonPressed(_ sender: UIButton) {
        launchContactViewController()
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set("lastName", forKey: "sort-order")
        } else {
            UserDefaults.standard.set("firstName", forKey: "sort-order")
        }
        
        loadContacts()
    }
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sortValue = UserDefaults.standard.value(forKey: "sort-order") as? String {
            sortByLastSwitch.isOn = sortValue == "lastName"
        } else {
            sortByLastSwitch.isOn = false
        }
        
        loadContacts()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else { return }
        
        let height = headerView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize).height
        var headerFrame = headerView.frame
        if height != headerFrame.size.height {
            headerFrame.size.height = height
            headerView.frame = headerFrame
            tableView.tableHeaderView = headerView
        }
    }
    
    // MARK: Private
    
    private func launchContactViewController(withContactUUID uuid: String? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "ContactViewControllerNav") as! UINavigationController
        let contactViewController = navigationController.topViewController as! ContactViewController
        contactViewController.contactUUID = uuid
        present(navigationController, animated: true, completion: nil)
    }
    
    private func launchCallViewController(withContactUUID uuid: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let callViewController = storyboard.instantiateViewController(withIdentifier: "CallViewController") as! CallViewController
        callViewController.modalPresentationStyle = .custom
        callViewController.modalTransitionStyle = .crossDissolve
        callViewController.contactUUID = uuid
        present(callViewController, animated: true, completion: nil)
    }
    
    private func loadContacts() {
        let realm = try! Realm()
        
        if sortByLastSwitch.isOn {
            contacts = realm.objects(Contact.self).sorted(byKeyPath: "lastName")
        } else {
            contacts = realm.objects(Contact.self).sorted(byKeyPath: "firstName")
        }
        
        contactsToken = contacts.observe { [weak self] changes in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension ContactsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
                return UITableViewCell()
        }
        
        let contact = contacts[indexPath.row]

        if contact.gender == .male {
            cell.avatarImageView.image = .male
        } else {
            cell.avatarImageView.image = .female
        }
        
        if sortByLastSwitch.isOn {
            cell.nameLabel.text = contact.lastName + ", " + contact.firstName
        } else {
            cell.nameLabel.text = contact.firstName + " " + contact.lastName
        }
        cell.phoneButton.isHidden = contact.phoneNumber.isEmpty
        cell.onPhoneButtonPressed = { [weak self] in
            self?.launchCallViewController(withContactUUID: contact.uuid)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ContactsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let contact = contacts[indexPath.row]
        launchContactViewController(withContactUUID: contact.uuid)
    }
}
