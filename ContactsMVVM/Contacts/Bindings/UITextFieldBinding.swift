//
//  UITextFieldBinding.swift
//  Contacts
//
//  Created by Rob Crabtree on 1/8/19.
//  Copyright © 2019 Rob Crabtree. All rights reserved.
//

import UIKit

class UITextFieldBinding {
    
    weak var textField: UITextField?
    weak var observable: Observable<String>?
    
    func bind(_ textField: UITextField) -> UITextFieldBinding {
        self.textField = textField
        textField.addTarget(self,
                            action: #selector(textDidChange(sender:)),
                            for: .editingChanged)
        return self
    }
    
    func to(_ observable: Observable<String>) -> UITextFieldBinding {
        self.observable = observable
        observable.observe = { [weak self] value in
            self?.textField?.text = value
        }
        textField?.text = observable.get()
        return self
    }
    
    @objc private func textDidChange(sender: UITextField) {
        observable?.set(value: sender.text ?? "", notify: false)
    }
}
