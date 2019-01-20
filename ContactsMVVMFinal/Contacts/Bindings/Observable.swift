//
//  Observable.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/8/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import Foundation

class Observable<T> {
    
    var observe: ((T) -> Void)?
    
    private var value: T
    
    init(_ value: T) {
        self.value = value
    }
    
    func set(value: T, notify: Bool = true) {
        self.value = value
        if notify {
            observe?(value)
        }
    }
    
    func get() -> T {
        return value
    }
}
