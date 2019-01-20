//
//  Contact.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/5/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

struct Contact {
    enum Gender: String {
        case male
        case female
    }

    var uuid: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var gender: Gender
}
