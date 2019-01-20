//
//  UISegmentedControlBinding.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/8/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

class UISegmentedControlBinding<T: RawRepresentable> where T.RawValue == Int {
    
    weak var segmentedControl: UISegmentedControl?
    weak var observable: Observable<T>?
    
    private var observationBlock: ((T) -> Void)?

    func bind(_ segmentedControl: UISegmentedControl) -> UISegmentedControlBinding {
        self.segmentedControl = segmentedControl
        segmentedControl.addTarget(self,
                                   action: #selector(valueDidChange(sender:)),
                                   for: .valueChanged)
        return self
    }
    
    func to(_ observable: Observable<T>) -> UISegmentedControlBinding {
        self.observable = observable
        observable.observe = { [weak self] value in
            self?.segmentedControl?.selectedSegmentIndex = value.rawValue
        }
        segmentedControl?.selectedSegmentIndex = observable.get().rawValue
        return self
    }
    
    func observe(_ observationBlock: @escaping  (T) -> Void) -> UISegmentedControlBinding {
        self.observationBlock = observationBlock
        observationBlock(observable!.get())
        return self
    }
    
    @objc private func valueDidChange(sender: UISegmentedControl) {
        guard let value = T(rawValue: sender.selectedSegmentIndex) else { return }
        observable?.set(value: value, notify: false)
        observationBlock?(value)
    }
}
