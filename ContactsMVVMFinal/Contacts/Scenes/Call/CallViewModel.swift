//
//  CallViewModel.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/7/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import Foundation
import RealmSwift

class CallViewModel {
    
    private let contact: Contact
    
    var name: String {
        return contact.firstName + " " + contact.lastName
    }
    
    var gender: Contact.Gender {
        return contact.gender
    }
    
    init(contactUUID: String) {
        let realm = try! Realm()
        contact = realm.object(ofType: Contact.self, forPrimaryKey: contactUUID)!
    }
}
