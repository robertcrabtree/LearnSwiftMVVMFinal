//
//  ContactViewModel.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/6/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

// Acts as a liaison between view controller and model objects

class ContactViewModel {
    
    let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    var firstName: String {
        return contact.firstName
    }
    
    var lastName: String {
        return contact.lastName
    }

    var phoneNumber: String {
        return contact.phoneNumber
    }

    var gender: Contact.Gender {
        return contact.gender
    }
}
