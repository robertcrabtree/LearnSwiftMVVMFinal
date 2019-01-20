//
//  ContactsViewModel.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/7/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import RealmSwift

class ContactsViewModel {
    
    var didMakeUpdates: (() -> Void)?
    
    var sortByLast: Bool {
        didSet {
            if sortByLast {
                UserDefaults.standard.set("lastName", forKey: "sort-order")
            } else {
                UserDefaults.standard.set("firstName", forKey: "sort-order")
            }
            loadContacts()
        }
    }
    
    var numContacts: Int {
        return contacts.count
    }
    
    private var contacts: Results<Contact>!
    private var contactsToken: NotificationToken!

    init() {
        if let sortOrder = UserDefaults.standard.value(forKey: "sort-order") as? String {
            sortByLast = sortOrder == "lastName"
        } else {
            sortByLast = false
        }
        loadContacts()
    }
    
    public func contactUUID(at indexPath: IndexPath) -> String {
        return contacts[indexPath.row].uuid
    }
    
    public func cellViewModel(at indexPath: IndexPath) -> ContactCellViewModel {
        return ContactCellViewModel(contactUUID: contacts[indexPath.row].uuid,
                                    lastNameFirst: sortByLast)
    }

    private func loadContacts() {
        let realm = try! Realm()
        
        if sortByLast {
            contacts = realm.objects(Contact.self).sorted(byKeyPath: "lastName")
        } else {
            contacts = realm.objects(Contact.self).sorted(byKeyPath: "firstName")
        }
        
        contactsToken = contacts.observe { [weak self] changes in
            self?.didMakeUpdates?()
        }
    }
}
