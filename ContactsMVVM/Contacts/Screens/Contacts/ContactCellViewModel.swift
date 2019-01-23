//
//  ContactCellViewModel.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/7/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import RealmSwift

class ContactCellViewModel {
    
    private let contact: Contact
    private let lastNameFirst: Bool
    
    var gender: Contact.Gender {
        return contact.gender
    }
    
    var name: String {
        return lastNameFirst
            ? contact.lastName + ", " + contact.firstName
            : contact.firstName + " " + contact.lastName
    }
    
    var isPhoneNumberEmpty: Bool {
        return contact.phoneNumber.isEmpty
    }

    init(contactUUID: String, lastNameFirst: Bool) {
        let realm = try! Realm()
        self.contact = realm.object(ofType: Contact.self, forPrimaryKey: contactUUID)!
        self.lastNameFirst = lastNameFirst
    }
}
