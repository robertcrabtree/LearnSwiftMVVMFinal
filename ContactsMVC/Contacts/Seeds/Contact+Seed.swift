//
//  Contact+Seed.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/5/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import Foundation

extension Contact {
    static func seed() -> [Contact] {
        
        return [
            Contact(
                uuid: UUID().uuidString,
                firstName: "Jim",
                lastName: "Armstrong",
                phoneNumber: "1234567890",
                gender: .male
            ),
            Contact(
                uuid: UUID().uuidString,
                firstName: "Bob",
                lastName: "Smith",
                phoneNumber: "1234567890",
                gender: .male
            ),
            Contact(
                uuid: UUID().uuidString,
                firstName: "Joe",
                lastName: "Williams",
                phoneNumber: "",
                gender: .male
            ),
            Contact(
                uuid: UUID().uuidString,
                firstName: "Suzy",
                lastName: "Jones",
                phoneNumber: "1234567890",
                gender: .female
            ),
            Contact(
                uuid: UUID().uuidString,
                firstName: "Lucy",
                lastName: "Brown",
                phoneNumber: "",
                gender: .female
            ),
        ]
    }
}
