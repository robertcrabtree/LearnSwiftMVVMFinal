//
//  ContactViewModelTest.swift
//  ContactsTests
//
//  Created by Rob Crabtree on 1/8/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Contacts

class ContactViewModelTest: XCTestCase {

    var realm: Realm!
    
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Test"
        realm = try! Realm()
    }

    override func tearDown() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func testCreate() {
        
        // Create and configure view model
        
        let viewModel = ContactViewModel(contactUUID: nil)
        viewModel.firstName.set(value: "Kathy")
        viewModel.lastName.set(value: "Williams")
        viewModel.phoneNumber.set(value: "0987654321")
        viewModel.gender.set(value: .female)
        
        // Verify there are no existing objects
        
        XCTAssertEqual(realm.objects(Contact.self).count, 0)

        // Save the new object

        viewModel.save()
        
        // Verify the object was created

        XCTAssertEqual(realm.objects(Contact.self).count, 1)
        
        // Verify the object's data

        let createdContact = realm.objects(Contact.self).first
        XCTAssertEqual(createdContact?.firstName, "Kathy")
        XCTAssertEqual(createdContact?.lastName, "Williams")
        XCTAssertEqual(createdContact?.phoneNumber, "0987654321")
        XCTAssertEqual(createdContact?.gender, .female)
    }
    
    func testUpdate() {
        
        // Create the object

        let contact = Contact(
            uuid: UUID().uuidString,
            firstName: "Kathy",
            lastName: "Williams",
            phoneNumber: "0987654321",
            gender: .female
        )
        
        // Save the object

        try! realm.write {
            realm.add(contact)
        }
        
        // Create and configure view model

        let viewModel = ContactViewModel(contactUUID: contact.uuid)
        
        // Update the view model data
        
        viewModel.firstName.set(value: "Bob")
        viewModel.lastName.set(value: "Smith")
        viewModel.phoneNumber.set(value: "1234567890")
        viewModel.gender.set(value: .male)

        // Verify there is only one object

        XCTAssertEqual(realm.objects(Contact.self).count, 1)

        // Save the updated object

        viewModel.save()
        
        // Verify there is still only one object

        XCTAssertEqual(realm.objects(Contact.self).count, 1)

        // Verify the object's data

        let updatedContact = realm.objects(Contact.self).first
        XCTAssertEqual(updatedContact?.firstName, "Bob")
        XCTAssertEqual(updatedContact?.lastName, "Smith")
        XCTAssertEqual(updatedContact?.phoneNumber, "1234567890")
        XCTAssertEqual(updatedContact?.gender, .male)
    }
    
    func testIsValidContact() {
        
        // Create view model
        
        let viewModel = ContactViewModel(contactUUID: nil)
        
        // Set some invalid data

        viewModel.firstName.set(value: "")
        viewModel.lastName.set(value: "")
        
        // Verify that isValidContact returns false when data is invalid

        XCTAssertFalse(viewModel.isValidContact())
        
        // Set some valid data

        viewModel.firstName.set(value: "Kathy")
        viewModel.lastName.set(value: "Williams")
        
        // Verify that isValidContact returns true when data is valid

        XCTAssertTrue(viewModel.isValidContact())
    }
}
