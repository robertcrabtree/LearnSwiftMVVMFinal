//
//  ContactViewModel.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/7/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import RealmSwift

class ContactViewModel {
    
    var firstName = Observable("")
    var lastName = Observable("")
    var phoneNumber = Observable("")
    var gender = Observable(Contact.Gender.male)
    
    private var contactUUID: String?

    init(contactUUID: String?) {
        self.contactUUID = contactUUID
        
        guard let contactUUID = contactUUID else { return }
        let realm = try! Realm()
        let contact = realm.object(
            ofType: Contact.self,
            forPrimaryKey: contactUUID
        )!
        
        firstName.set(value: contact.firstName)
        lastName.set(value: contact.lastName)
        phoneNumber.set(value: contact.phoneNumber)
        gender.set(value: contact.gender)
    }
    
    func save() {
        let contact = Contact(
            uuid: contactUUID ?? UUID().uuidString,
            firstName: firstName.get(),
            lastName: lastName.get(),
            phoneNumber: phoneNumber.get(),
            gender: gender.get()
        )
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(contact, update: true)
        }
    }
    
    func isValidContact() -> Bool {
        return !firstName.get().isEmpty && !lastName.get().isEmpty
    }
}
