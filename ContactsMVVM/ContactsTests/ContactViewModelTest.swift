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
        fatalError("Not implemented")
    }
}
