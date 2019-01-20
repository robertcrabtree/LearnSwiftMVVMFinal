//
//  Contact.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/5/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import RealmSwift

class Contact: Object {
    @objc enum Gender: Int {
        case male
        case female
    }

    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var phoneNumber = ""
    @objc dynamic var gender = Gender.male
    
    convenience init(uuid: String,
                     firstName: String,
                     lastName: String,
                     phoneNumber: String,
                     gender: Gender) {
        self.init()
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.gender = gender
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
